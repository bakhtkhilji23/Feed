import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:news_pro/core/routes/app_routes.dart';
import 'package:news_pro/views/home/home_page/components/loading_posts_responsive.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/controllers/posts/categories_post_controller.dart';
import '../../../../core/models/article.dart';
import '../../../views/home/post_page/components/save_post_button.dart';
// import 'loading_posts_responsive.dart';

class PoemsTagView extends ConsumerWidget {
  const PoemsTagView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final CategoryPostsArguments arguments;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final postsProvider = ref.watch(categoryPostController(arguments));
    final controller = ref.watch(categoryPostController(arguments).notifier);

    if (postsProvider.refershError) {
      return Center(
        child: Text(postsProvider.errorMessage),
      );

      /// on Initial State it will be empty
    } else if (postsProvider.initialLoaded == false) {
      // return const LoadingPostsResponsive(isInSliver: false);
      return Padding(
        padding: EdgeInsets.only(bottom: height * 0.233),
        child: CupertinoActivityIndicator(
          radius: 20,
        ),
      );
    } else if (postsProvider.posts.isEmpty) {
      return const PoemsPostEmpty();
    } else {
      return RefreshIndicator(
        onRefresh: controller.onRefresh,
        child: Scrollbar(
          child: CustomScrollView(
            slivers: [
              PoemsPostListView(
                data: postsProvider.posts,
                handlePagination: controller.handleScrollWithIndex,
                onRefresh: controller.onRefresh,
              ),
              if (postsProvider.isPaginationLoading)
                const SliverToBoxAdapter(
                  child: LinearProgressIndicator(),
                )
            ],
          ),
        ),
      );
    }
  }
}

class PoemsPostListView extends StatelessWidget {
  const PoemsPostListView({
    Key? key,
    required this.data,
    required this.handlePagination,
    required this.onRefresh,
  }) : super(key: key);

  final List<ArticleModel> data;
  final void Function(int) handlePagination;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: SliverPadding(
        padding: const EdgeInsets.only(
          top: AppDefaults.padding,
          left: AppDefaults.padding,
          right: AppDefaults.padding,
        ),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              // handleScrollWithIndex(index);
              if(index == 0){
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Center(
                        child: Text(
                          'The very first messages that Suzanne Giesemann received from spirit were in the form of poems. Suzanne does not write poetry and this was a way for her guides to convince her that the messages were truly from spirit. The very first poem from spirit was delivered on July 12, 2009. After one year, her guides switched to delivering their messages in prose. Enjoy this first year of poems filled with inspiration and wisdom.',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.amber,
                      thickness: 0.75,
                    ),
                    const SizedBox(height: 10)
                  ],
                );
              }
              return InkWell(
                onTap: () {
                  // Navigator.of(context).pushNamed();
                  Navigator.pushNamed(
                    context,
                    AppRoutes.poem,
                    arguments: data[index - 1],
                  );
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 7,
                          fit: FlexFit.tight,
                          child: Text(
                            data[index - 1].title,
                            maxLines: 2,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: TimeWidget(data: data[index- 1]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      color: Colors.amber,
                      thickness: 0.75,
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              );
            },
            childCount: data.length + 1,
          ),
        ),

        // ResponsiveListView(
        //   data: data,
        //   handleScrollWithIndex: handlePagination,
        //   isMainPage: true,
        // ),
      ),
    );
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ArticleModel data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.schedule, color: AppColors.primary),
        const SizedBox(width: 4),
        Text(DateFormat('MMM dd, yyyy').format(data.date),
            style: Theme.of(context)
                .primaryTextTheme
                .caption
                ?.copyWith(color: Colors.black, fontSize: 10))
      ],
    );
  }
}

class PoemsPostEmpty extends StatelessWidget {
  const PoemsPostEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Image.asset(AppImages.emptyPost),
          ),
          AppSizedBox.h16,
          Text(
            'Ooh! It\'s empty here',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          AppSizedBox.h10,
          Text(
            'You can explore other categories as well',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
