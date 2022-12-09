import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../core/components/list_view_responsive.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/controllers/posts/post_pagination_class.dart';
import '../../../../core/controllers/posts/recent_posts_controller.dart';
import 'loading_posts_responsive.dart';

class RecentPostFetcherSection extends ConsumerWidget {
  const RecentPostFetcherSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentPosts = ref.watch(recentPostController);
    final notifer = ref.watch(recentPostController.notifier);

    if (recentPosts.initialLoaded == false) {
      return const LoadingPostsResponsive();
    } else if (recentPosts.refershError) {
      return Center(child: Text(recentPosts.errorMessage));
    } else if (recentPosts.posts.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(child: Text('No Posts Found')),
      );
    } else {
      return MultiSliver(
        children: [
          RecentPostList(
            recentPosts: recentPosts,
            notifer: notifer,
          ),
          if (recentPosts.isPaginationLoading)
            const SliverToBoxAdapter(child: LinearProgressIndicator()),
        ],
      );
    }
  }
}

class RecentPostList extends StatelessWidget {
  const RecentPostList({
    Key? key,
    required PostPagination recentPosts,
    required RecentPostsController notifer,
  })  : _recentPosts = recentPosts,
        _notifer = notifer,
        super(key: key);

  final PostPagination _recentPosts;
  final RecentPostsController _notifer;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: AppDefaults.padding / 2,
      ),
      sliver: ResponsiveListView(
        data: _recentPosts.posts,
        handleScrollWithIndex: _notifer.handleScrollWithIndex,
        isMainPage: true,
      ),
    );
  }
}
