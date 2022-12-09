import 'dart:convert';

class AuthorData {
  String name;
  String avatarUrl;
  int userID;
  AuthorData({
    required this.name,
    required this.avatarUrl,
    required this.userID,
  });

  factory AuthorData.fromMap(Map<String, dynamic> map) {
    return AuthorData(
      name: map['name'] ?? '',
      avatarUrl: map['avatar_urls']['24'] ?? '',
      userID: map['id']?.toInt() ?? 0,
    );
  }

  factory AuthorData.fromJson(String source) =>
      AuthorData.fromMap(json.decode(source));
}
