import 'dart:convert';

class Member {
  String name;
  String email;
  String avatarUrl;
  Member({required this.name, required this.email, required this.avatarUrl});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  factory Member.fromLocal(Map<String, dynamic> map) {
    return Member(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      avatarUrl: map['user_avatar_url'] ?? '',
    );
  }

  factory Member.fromServer(Map<String, dynamic> map) {
    return Member(
      name: map['user_display_name'] ?? '',
      email: map['user_email'] ?? '',
      avatarUrl: map['user_avatar_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Member.fromJson(String source) =>
      Member.fromLocal(json.decode(source));
}
