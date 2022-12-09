import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../core/ads/ad_state_provider.dart';
import '../../core/components/list_view_responsive.dart';
import '../../core/constants/constants.dart';
import '../../core/controllers/posts/categories_post_controller.dart';
import '../../core/controllers/posts/post_pagination_class.dart';
import '../../core/models/category.dart';
import '../home/home_page/components/loading_posts_responsive.dart';
import 'components/empty_categories.dart';

class CategoryPageArguments {
  final CategoryModel category;
  final String backgroundImage;
  CategoryPageArguments({
    required this.category,
    required this.backgroundImage,
  });
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final CategoryPageArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              leadingWidth: MediaQuery.of(context).size.width * 0.2,
              expandedHeight: MediaQuery.of(context).size.height * 0.20,
              backgroundColor: AppColors.primary,
              iconTheme: const IconThemeData(color: Colors.white),
              flexibleSpace: FlexibleSpaceBar(
                title: Html(
                  data: arguments.category.name,
                  style: {
                    'body': Style(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      fontSize: const FontSize(16.0),
                      lineHeight: const LineHeight(1.4),
                      color: Colors.white,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                    'figure': Style(
                        margin: EdgeInsets.zero, padding: EdgeInsets.zero),
                  },
                ),
                expandedTitleScale: 2,
                centerTitle: true,
                background: AspectRatio(
                  aspectRatio: AppDefaults.aspectRatio,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          arguments.backgroundImage,
                        ),
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                          Colors.black54,
                          BlendMode.darken,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            CategoriesArticles(
              arguments: CategoryPostsArguments(
                categoryId: arguments.category.id,
                isHome: false,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(color: Theme.of(context).cardColor),
            )
          ],
        ),
      ),
    );
  }
}

class CategoriesArticles extends ConsumerWidget {
  const CategoriesArticles({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final CategoryPostsArguments arguments;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(loadInterstitalAd);
    final paginationController = ref.watch(categoryPostController(arguments));
    final controller = ref.watch(categoryPostController(arguments).notifier);

    if (paginationController.refershError) {
      return SliverToBoxAdapter(
        child: Center(child: Text(paginationController.errorMessage)),
      );

      /// on Initial State it will be empty
    } else if (paginationController.initialLoaded == false) {
      return const LoadingPostsResponsive();
    } else if (paginationController.posts.isEmpty) {
      return const SliverToBoxAdapter(child: EmptyCategoriesList());
    } else {
      return MultiSliver(
        children: [
          CategoriesArticlesList(
            controller: controller,
            paginationController: paginationController,
          ),
          if (paginationController.isPaginationLoading)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LoadingAnimationWidget.threeArchedCircle(
                    color: AppColors.primary, size: 36),
              ),
            ),
        ],
      );
    }
  }
}

class CategoriesArticlesList extends StatelessWidget {
  const CategoriesArticlesList({
    Key? key,
    required CategoryPostsController controller,
    required PostPagination paginationController,
  })  : _controller = controller,
        _paginationController = paginationController,
        super(key: key);

  final CategoryPostsController _controller;
  final PostPagination _paginationController;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      sliver: ResponsiveListView(
        data: _paginationController.posts,
        handleScrollWithIndex: _controller.handleScrollWithIndex,
      ),
    );
  }
}
