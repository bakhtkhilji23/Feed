import 'package:flutter/foundation.dart';

import '../../models/comment.dart';

class CommentPagination {
  List<CommentModel> comments;
  int page;
  String errorMessage;
  bool initialLoaded;
  bool isPaginationLoading;
  CommentPagination({
    required this.comments,
    required this.page,
    required this.errorMessage,
    required this.initialLoaded,
    required this.isPaginationLoading,
  });

  CommentPagination.initial()
      : comments = [],
        page = 1,
        errorMessage = '',
        initialLoaded = false,
        isPaginationLoading = false;

  bool get refreshError => errorMessage != '' && comments.length <= 10;

  CommentPagination copyWith({
    List<CommentModel>? comments,
    int? page,
    String? errorMessage,
    bool? initialLoaded,
    bool? isPaginationLoading,
  }) {
    return CommentPagination(
      comments: comments ?? this.comments,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
      initialLoaded: initialLoaded ?? this.initialLoaded,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }

  @override
  String toString() =>
      'CommentPagination(comments: $comments, page: $page, errorMessage: $errorMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentPagination &&
        listEquals(other.comments, comments) &&
        other.page == page &&
        other.errorMessage == errorMessage &&
        other.initialLoaded == initialLoaded &&
        other.isPaginationLoading == isPaginationLoading;
  }

  @override
  int get hashCode =>
      comments.hashCode ^
      page.hashCode ^
      errorMessage.hashCode ^
      isPaginationLoading.hashCode ^
      initialLoaded.hashCode;
}
