import 'dart:convert';

class PostTag {
  int id;
  String name;
  String link;
  int count;
  PostTag({
    required this.id,
    required this.name,
    required this.link,
    required this.count,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'link': link,
      'count': count,
    };
  }

  factory PostTag.fromMap(Map<String, dynamic> map) {
    return PostTag(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      link: map['link'] ?? '',
      count: map['count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostTag.fromJson(String source) =>
      PostTag.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostTag(id: $id, name: $name, link: $link, count: $count)';
  }
}
