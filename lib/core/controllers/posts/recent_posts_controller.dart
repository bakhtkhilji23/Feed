import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repositories/posts/post_repository.dart';
import 'post_pagination_class.dart';

final recentPostController =
    StateNotifierProvider<RecentPostsController, PostPagination>((ref) {
  final postRepo = ref.read(postRepoProvider);
  return RecentPostsController(postRepo);
});

class RecentPostsController extends StateNotifier<PostPagination> {
  RecentPostsController(
    this.repository, [
    PostPagination? state,
  ]) : super(state ?? PostPagination.initial()) {
    {
      getPosts();
    }
  }

  final PostRepository repository;

  bool _isAlreadyLoading = false;

  getPosts() async {
    if (_isAlreadyLoading) {
    } else {
      _isAlreadyLoading = true;

      try {
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          if (mounted && state.page > 1) {
            state = state.copyWith(isPaginationLoading: true);
          }
        });

        final fetched = await repository.getAllPost(pageNumber: state.page);

        /// Make's seperate list for categories with different hero ID

        final posts = fetched
            .map((e) => e.copyWith(heroTag: '${e.link}recents'))
            .toList();

        if (mounted && state.page == 1) {
          state = state.copyWith(initialLoaded: true);
        }

        if (mounted) {
          state = state.copyWith(
            posts: [...state.posts, ...posts],
            page: state.page + 1,
            isPaginationLoading: false,
          );
        }
      } on Exception {
        state = state.copyWith(
          errorMessage: 'Fetch Error',
          initialLoaded: true,
          isPaginationLoading: false,
        );
      }
      _isAlreadyLoading = false;
    }
  }

  void handleScrollWithIndex(int index) {
    final itemPosition = index + 1;
    final requestMoreData = itemPosition % 10 == 0 && itemPosition != 0;

    final pageToRequest = itemPosition ~/ 10;
    if (requestMoreData && pageToRequest + 1 >= state.page) {
      getPosts();
    }
  }

  Future<void> onRefresh() async {
    state = PostPagination.initial();
    await getPosts();
  }
}
