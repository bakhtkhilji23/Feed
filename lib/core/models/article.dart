import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../config/app_images_config.dart';

class ArticleModel {
  int id;
  String title;
  String content;
  String link;
  String featuredImage;
  String heroTag;
  List<int> categories;
  List<int> tags;
  DateTime date;
  bool commentStatus;
  int authorID;
  ArticleModel({
    required this.id,
    required this.title,
    required this.content,
    required this.link,
    required this.featuredImage,
    required this.heroTag,
    required this.categories,
    required this.tags,
    required this.date,
    required this.commentStatus,
    required this.authorID,
  });

  ArticleModel copyWith({
    int? id,
    String? title,
    String? content,
    String? link,
    String? featuredImage,
    String? heroTag,
    List<int>? categories,
    List<int>? tags,
    DateTime? date,
    bool? commentStatus,
    int? authorID,
  }) {
    return ArticleModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      link: link ?? this.link,
      featuredImage: featuredImage ?? this.featuredImage,
      heroTag: heroTag ?? this.heroTag,
      categories: categories ?? this.categories,
      tags: tags ?? this.tags,
      date: date ?? this.date,
      commentStatus: commentStatus ?? this.commentStatus,
      authorID: authorID ?? this.authorID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'link': link,
      'featuredImage': featuredImage,
      'heroTag': heroTag,
      'categories': categories,
      'tags': tags,
      'date': date.millisecondsSinceEpoch,
      'commentStatus': commentStatus,
      'authorID': authorID,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title']['rendered'],
      content: map['content']['rendered'] ?? '',
      link: map['link'] ?? '',
      featuredImage: map['featured_image_url'] ?? AppImagesConfig.noImageUrl,
      heroTag: map['slug'] ?? '',
      categories: List<int>.from(map['categories']),
      tags: List<int>.from(map['tags']),
      date: DateTime.parse(map['date_gmt']),
      commentStatus: map['comment_status'].toString() == 'open' ? true : false,
      authorID: map['author']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleModel.fromJson(String source) =>
      ArticleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ArticleModel(id: $id, title: $title, content: $content, link: $link, featuredImage: $featuredImage, heroTag: $heroTag, categories: $categories, tags: $tags, date: $date, commentStatus: $commentStatus, authorID: $authorID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ArticleModel &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.link == link &&
        other.featuredImage == featuredImage &&
        listEquals(other.categories, categories) &&
        listEquals(other.tags, tags) &&
        other.date == date &&
        other.commentStatus == commentStatus &&
        other.authorID == authorID;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        link.hashCode ^
        featuredImage.hashCode ^
        heroTag.hashCode ^
        categories.hashCode ^
        tags.hashCode ^
        date.hashCode ^
        commentStatus.hashCode ^
        authorID.hashCode;
  }
}

// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    this.id,
    this.postAuthor,
    this.postDate,
    this.postDateGmt,
    this.postContent,
    this.postTitle,
    this.postExcerpt,
    this.postStatus,
    this.commentStatus,
    this.pingStatus,
    this.postPassword,
    this.postName,
    this.toPing,
    this.pinged,
    this.postModified,
    this.postModifiedGmt,
    this.postContentFiltered,
    this.postParent,
    this.guid,
    this.menuOrder,
    this.postType,
    this.postMimeType,
    this.commentCount,
    this.filter,
    this.thumbnail,
  });

  int? id;
  String? postAuthor;
  DateTime? postDate;
  DateTime? postDateGmt;
  String? postContent;
  String? postTitle;
  String? postExcerpt;
  String? postStatus;
  String? commentStatus;
  String? pingStatus;
  String? postPassword;
  String? postName;
  String? toPing;
  String? pinged;
  DateTime? postModified;
  DateTime? postModifiedGmt;
  String? postContentFiltered;
  int? postParent;
  String? guid;
  int? menuOrder;
  String? postType;
  String? postMimeType;
  String? commentCount;
  String? filter;
  String? thumbnail;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["ID"],
        postAuthor: json["post_author"],
        postDate: DateTime.parse(json["post_date"]),
        postDateGmt: DateTime.parse(json["post_date_gmt"]),
        postContent: json["post_content"],
        postTitle: json["post_title"],
        postExcerpt: json["post_excerpt"],
        postStatus: json["post_status"],
        commentStatus: json["comment_status"],
        pingStatus: json["ping_status"],
        postPassword: json["post_password"],
        postName: json["post_name"],
        toPing: json["to_ping"],
        pinged: json["pinged"],
        postModified: DateTime.parse(json["post_modified"]),
        postModifiedGmt: DateTime.parse(json["post_modified_gmt"]),
        postContentFiltered: json["post_content_filtered"],
        postParent: json["post_parent"],
        guid: json["guid"],
        menuOrder: json["menu_order"],
        postType: json["post_type"],
        postMimeType: json["post_mime_type"],
        commentCount: json["comment_count"],
        filter: json["filter"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "post_author": postAuthor,
        "post_date": postDate!.toIso8601String(),
        "post_date_gmt": postDateGmt!.toIso8601String(),
        "post_content": postContent,
        "post_title": postTitle,
        "post_excerpt": postExcerpt,
        "post_status": postStatus,
        "comment_status": commentStatus,
        "ping_status": pingStatus,
        "post_password": postPassword,
        "post_name": postName,
        "to_ping": toPing,
        "pinged": pinged,
        "post_modified": postModified!.toIso8601String(),
        "post_modified_gmt": postModifiedGmt!.toIso8601String(),
        "post_content_filtered": postContentFiltered,
        "post_parent": postParent,
        "guid": guid,
        "menu_order": menuOrder,
        "post_type": postType,
        "post_mime_type": postMimeType,
        "comment_count": commentCount,
        "filter": filter,
        "thumbnail": thumbnail,
      };
}
