import 'dart:convert';

class CategoryModel {
  int id;
  String name;
  String slug;
  String link;
  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.link,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id']?.toInt(),
      name: map['name'],
      slug: map['slug'],
      link: map['link'],
    );
  }

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Category(id: $id, name: $name, slug: $slug, link: $link)';
  }
}
