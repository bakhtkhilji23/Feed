import 'package:flutter/foundation.dart';

import '../../models/article.dart';

class PostPagination {
  List<ArticleModel> posts;
  int page;
  String errorMessage;
  bool initialLoaded;
  bool isPaginationLoading;
  PostPagination({
    required this.posts,
    required this.page,
    required this.errorMessage,
    required this.initialLoaded,
    required this.isPaginationLoading,
  });

  PostPagination.initial()
      : posts = [],
        page = 1,
        errorMessage = '',
        initialLoaded = false,
        isPaginationLoading = false;

  bool get refershError => errorMessage != '' && posts.length <= 10;

  PostPagination copyWith({
    List<ArticleModel>? posts,
    int? page,
    String? errorMessage,
    bool? initialLoaded,
    bool? isPaginationLoading,
  }) {
    return PostPagination(
      posts: posts ?? this.posts,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
      initialLoaded: initialLoaded ?? this.initialLoaded,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostPagination &&
        listEquals(other.posts, posts) &&
        other.page == page &&
        other.errorMessage == errorMessage &&
        other.initialLoaded == initialLoaded &&
        other.isPaginationLoading == isPaginationLoading;
  }

  @override
  int get hashCode =>
      posts.hashCode ^
      page.hashCode ^
      errorMessage.hashCode ^
      isPaginationLoading.hashCode ^
      initialLoaded.hashCode;
}
