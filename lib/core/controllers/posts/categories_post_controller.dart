import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/wp_config.dart';
import '../../repositories/posts/post_repository.dart';
import 'post_pagination_class.dart';

class CategoryPostsArguments {
  final int categoryId;
  final bool isHome;
  CategoryPostsArguments({
    required this.categoryId,
    required this.isHome,
  });
}

final categoryPostController = StateNotifierProvider.family.autoDispose<
    CategoryPostsController,
    PostPagination,
    CategoryPostsArguments>((ref, arguments) {
  final repo = ref.read(postRepoProvider);
  ref.maintainState = WPConfig.enableHomeTabCache;

  return CategoryPostsController(repo, arguments);
});

class CategoryPostsController extends StateNotifier<PostPagination> {
  CategoryPostsController(
    this.repository,
    this.arguments, [
    PostPagination? state,
  ]) : super(state ?? PostPagination.initial()) {
    getPosts();
  }

  final PostRepository repository;
  final CategoryPostsArguments arguments;

  bool _isAlreadyLoading = false;

  getPosts() async {
    if (_isAlreadyLoading) {
    } else {
      _isAlreadyLoading = true;
      try {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (mounted && state.page > 1) {
            state = state.copyWith(isPaginationLoading: true);
          }
        });

        final fetched = await repository.getPostByCategory(
          pageNumber: state.page,
          categoryID: arguments.categoryId,
        );

        /// Make's seperate list for categories with different hero ID
        String isFeature = arguments.isHome ? 'featuredArticle' : '';
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
