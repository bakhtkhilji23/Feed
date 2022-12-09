import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/wp_config.dart';
import '../../models/post_tag.dart';
import '../../repositories/posts/post_repository.dart';
import 'post_pagination_class.dart';

final tagPostController = StateNotifierProvider.family
    .autoDispose<TagPostController, PostPagination, PostTag>((ref, arguments) {
  final repo = ref.read(postRepoProvider);
  ref.maintainState = WPConfig.enableHomeTabCache;

  return TagPostController(repo, arguments);
});

class TagPostController extends StateNotifier<PostPagination> {
  TagPostController(
    this.repository,
    this.arguments, [
    PostPagination? state,
  ]) : super(state ?? PostPagination.initial()) {
    {
      getPosts();
    }
  }

  final PostRepository repository;
  final PostTag arguments;

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

        final fetched = await repository.getPostByTag(
          pageNumber: state.page,
          tagID: arguments.id,
        );

        /// Make's seperate list for categories with different hero ID
        String isFeature = 'tagID';
        final posts = fetched
            .map((e) => e.copyWith(heroTag: e.link + isFeature))
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
