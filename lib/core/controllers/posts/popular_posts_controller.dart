import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/wp_config.dart';
import '../../models/article.dart';
import '../../repositories/posts/post_repository.dart';

/// Provides Popular Posts
final popularPostsController = FutureProvider<List<ArticleModel>>((ref) async {
  final repo = ref.read(postRepoProvider);

  /// If popular post plugin is enabled and no custom feature category is provided
  List<ArticleModel> allPosts =
      await repo.getPopularPosts(isPlugin: WPConfig.isPopularPostPluginEnabled);

  /// If popular post plugin is disabled
  if (WPConfig.isPopularPostPluginEnabled == false) {
    allPosts = await repo.getAllPost(pageNumber: 1);
  }

  /// On Smaller sites the popular post plugin takes some time to indexing
  /// the most popular sites, so if we don't want our users to go empty hand
  /// we must use a backup category
  if (allPosts.isEmpty) {
    allPosts = await repo.getPopularPosts(isPlugin: false);
  }

  final updatedList =
      allPosts.map((e) => e.copyWith(heroTag: '${e.link}popular')).toList();

  return updatedList;
});
