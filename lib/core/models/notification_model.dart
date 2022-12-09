import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';

/// A Model that represents a Notification
class NotificationModel {
  String? id;
  String title;
  String? subtitle;
  DateTime recievedTime;
  String? postURL;
  String? imageURL;
  int? postID;
  NotificationModel({
    this.id,
    required this.title,
    this.subtitle,
    required this.recievedTime,
    this.postURL,
    this.imageURL,
    this.postID,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'recievedTime': recievedTime.millisecondsSinceEpoch,
      'postURL': postURL,
      'imageURL': imageURL,
      'postID': postID,
      'id': id,
    };
  }

  factory NotificationModel.fromMessage(RemoteMessage message, DateTime time) {
    return NotificationModel(
      title: message.data['title'],
      subtitle: message.data['message'],
      recievedTime: time,
      postURL: message.data['url'],
      imageURL: message.data['image'],
      postID: int.parse(message.data['post_id']),
    );
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] ?? '',
      subtitle: map['subtitle'],
      recievedTime: DateTime.fromMillisecondsSinceEpoch(map['recievedTime']),
      postURL: map['postURL'],
      imageURL: map['imageURL'],
      postID: map['postID']?.toInt(),
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.recievedTime == recievedTime &&
        other.postURL == postURL &&
        other.imageURL == imageURL &&
        other.postID == postID;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        subtitle.hashCode ^
        recievedTime.hashCode ^
        postURL.hashCode ^
        imageURL.hashCode ^
        postID.hashCode;
  }

  @override
  String toString() {
    return 'NotificationModel(title: $title, subtitle: $subtitle, recievedTime: $recievedTime, postURL: $postURL, imageURL: $imageURL, postID: $postID)';
  }
}
