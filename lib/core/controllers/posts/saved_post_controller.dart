import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../views/saved/components/saved_article_tile.dart';
import '../../models/article.dart';
import '../../repositories/posts/post_local_repository.dart';
import '../../repositories/posts/post_repository.dart';

/// Provides The Saved Posts
final savedPostController =
    StateNotifierProvider<SavedPostNotifier, AsyncValue<List<ArticleModel>>>(
  (ref) => SavedPostNotifier(ref.read(postRepoProvider)),
);

class SavedPostNotifier extends StateNotifier<AsyncValue<List<ArticleModel>>> {
  SavedPostNotifier(this._repo) : super(const AsyncValue.data([])) {
    getAllSavedPost();
  }
  final PostRepository _repo;
  final _localRepo = PostLocalRepository();

  Future<List<ArticleModel>> getAllSavedPost() async {
    state = const AsyncLoading();
    final allPosts = await _repo.getsavedPosts();

    // Fix for hero animations
    final newList =
        allPosts.map((e) => e.copyWith(heroTag: '${e.link}saved')).toList();
    state = AsyncData(newList);

    return allPosts;
  }

  removePostFromSavedAnimated(
      {required int id, required int index, required ArticleModel tile}) async {
    final newList = state.value?.where((element) => element.id != id).toList();
    if (newList != null) {
      state = AsyncData(newList);
      _localRepo.deletePostID(id);
      animatedListKey.currentState?.removeItem(
        index,
        (context, animation) => SavedArticleTile(
          article: tile,
          animation: animation,
          index: index,
          onRefresh: () async {},
        ),
      );
    } else {
      state = const AsyncError('An error happened while removing article');
    }
  }

  removePostFromSaved(int id) async {
    try {
      final newList =
          state.value?.where((element) => element.id != id).toList();
      if (newList != null) {
        state = AsyncData(newList);
        _localRepo.deletePostID(id);
      } else {
        state = const AsyncError('An error happened while removing article');
      }
    } catch (exception) {
      isSavingPost = false;
    }
    // await onRefresh();
  }

  bool isSavingPost = false;

  addPostToSaved(ArticleModel article) async {
    if (isSavingPost) {
      return;
    }

    try {
      isSavingPost = true;
      final currentList = state.value;
      state = const AsyncLoading();
      final thePost = article.copyWith(heroTag: '${article.link}saved');

      if (currentList != null) {
        state = AsyncValue.data([...currentList, thePost]);
      }
      animatedListKey.currentState?.insertItem(0);
      await _localRepo.savePostID(article.id);
    } on Exception catch (_) {
      state = const AsyncError('Error! While adding post');
      Fluttertoast.showToast(msg: 'Error! While adding post');
      isSavingPost = false;
    } finally {}
    isSavingPost = false;
  }

  /// Used for animation when deleting or inserting Article
  final animatedListKey = GlobalKey<AnimatedListState>();

  /// on Refresh
  Future<void> onRefresh() async {
    state = const AsyncData([]);
    await getAllSavedPost();
  }
}
