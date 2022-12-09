import 'dart:convert';

class CommentModel {
  int id;
  int postID;
  String authorName;
  String avatarURL;
  String content;
  DateTime time;
  int parentCommentID;
  CommentModel({
    required this.id,
    required this.postID,
    required this.authorName,
    required this.avatarURL,
    required this.content,
    required this.time,
    required this.parentCommentID,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id']?.toInt(),
      postID: map['post']?.toInt(),
      authorName: map['author_name'],
      avatarURL: map['author_avatar_urls']['96'],
      content: map['content']['rendered'],
      parentCommentID: map['parent'] ?? 0,
      time: DateTime.parse(map['date_gmt']),
    );
  }

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommentModel(id: $id, postID: $postID, authorName: $authorName, avatarURL: $avatarURL, content: $content, time: $time), parent: $parentCommentID';
  }
}
