import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../core/components/headline_with_row.dart';
import '../../../../core/components/list_view_responsive.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/controllers/posts/more_post_controller.dart';
import '../../home_page/components/loading_posts_responsive.dart';

class MoreRelatedPost extends ConsumerWidget {
  const MoreRelatedPost({
    Key? key,
    required this.categoryID,
    required this.currentArticleID,
  }) : super(key: key);

  final int categoryID;
  final int currentArticleID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final morePost = ref.watch(moreRelatedPostController(categoryID));
    return SliverPadding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      sliver: MultiSliver(
        children: [
          const SliverToBoxAdapter(
            child: HeadlineRow(headline: 'more_related_posts'),
          ),
          const SliverToBoxAdapter(child: AppSizedBox.h16),

          /// LIST
          morePost.map(
            data: (data) {
              final updatedList = data.value
                  .where((element) => element.id != currentArticleID)
                  .toList();
              return ResponsiveListView(
                data: updatedList,
                handleScrollWithIndex: (v) {},
                isMainPage: true,
              );
            },
            error: (t) =>
                SliverToBoxAdapter(child: Center(child: Text(t.toString()))),
            loading: (t) => const LoadingPostsResponsive(),
          ),
        ],
      ),
    );
  }
}
