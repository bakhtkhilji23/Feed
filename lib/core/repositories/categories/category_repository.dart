import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../../config/wp_config.dart';
import '../../models/category.dart';

abstract class CategoriesRepoAbstract {
  /// Gets all the category from the website
  Future<List<CategoryModel>> getAllCategory();

  /// Get Single Category
  Future<CategoryModel?> getCategory(int id);
}

class CategoriesRepository extends CategoriesRepoAbstract {
  @override
  Future<List<CategoryModel>> getAllCategory() async {
    final client = http.Client();
    String url =
        'https://${WPConfig.url}/wp-json/wp/v2/categories/?per_page=100';
    List<CategoryModel> allCategories = [];
    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {}
      final allData = jsonDecode(response.body) as List;
      allCategories = allData.map((e) => CategoryModel.fromMap(e)).toList();
      allCategories = _removeBlockedCategories(allCategories);
      return allCategories;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return [];
    } finally {
      client.close();
    }
  }

  @override
  Future<CategoryModel?> getCategory(int id) async {
    final client = http.Client();
    String url = 'https://${WPConfig.url}/wp-json/wp/v2/categories/$id';
    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return CategoryModel.fromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    } finally {
      client.close();
    }
  }

  /// Removes Blocked Categories defined in [WPConfig]
  List<CategoryModel> _removeBlockedCategories(List<CategoryModel> data) {
    final blockedData = WPConfig.blockedCategoriesIds;
    for (var blockedID in blockedData) {
      data.removeWhere((element) => element.id == blockedID);
    }
    return data;
  }
}
