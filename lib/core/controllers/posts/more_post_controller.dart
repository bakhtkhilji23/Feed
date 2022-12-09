import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/article.dart';
import '../../repositories/posts/post_repository.dart';

final moreRelatedPostController = FutureProvider.autoDispose
    .family<List<ArticleModel>, int>((ref, categoryID) async {
  final repository = ref.read(postRepoProvider);
  List<ArticleModel> allPosts = [];

  allPosts =
      await repository.getPostByCategory(pageNumber: 1, categoryID: categoryID);

  if (allPosts.isEmpty) {
    allPosts = await repository.getAllPost(pageNumber: 1);
  }

  final returnList = allPosts
      .map((e) => e.copyWith(heroTag: '${e.link}more_related_posts'))
      .toList();

  return returnList;
});
