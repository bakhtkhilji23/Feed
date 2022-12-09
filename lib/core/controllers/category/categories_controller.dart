import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/app_images_config.dart';
import '../../../config/wp_config.dart';
import '../../../views/explore/category_page.dart';
import '../../models/category.dart';
import '../../repositories/categories/category_repository.dart';
import '../../routes/app_routes.dart';

final categoriesController =
    StateNotifierProvider<CategoriesNotifier, List<CategoryModel>>((ref) {
  return CategoriesNotifier();
});

class CategoriesNotifier extends StateNotifier<List<CategoryModel>> {
  CategoriesNotifier() : super([]) {
    getAllCategories();
  }

  final _repo = CategoriesRepository();

  final CategoryModel _featureCategory = CategoryModel(
    id: 0, // ignored
    name: WPConfig.featureCategoryName,
    slug: '', // ignored
    link: '', // ignored
  );

  Future<List<CategoryModel>> getAllCategories() async {
    final data = await _repo.getAllCategory();
    data.insert(0, _featureCategory);
    state = data;
    return state;
  }

  Future<List<CategoryModel>> getAllFeatureCategories() async {
    List<CategoryModel> categories = [];

    if (WPConfig.homeCategories.isNotEmpty) {
      WPConfig.homeCategories.forEach((id, name) {
        categories.add(
          CategoryModel(
            id: id,
            name: name,
            slug: '',
            link: '',
          ),
        );
      });
    } else {
      categories = await _repo.getAllCategory();
    }

    categories.insert(0, _featureCategory);

    return categories;
  }

  addCategories(List<CategoryModel> data) {
    state = [...state, ...data];
  }

  /// Provides Category Name From category id
  List<String> categoriesName(List<int> data) {
    List<String> names = [];
    for (var id in data) {
      try {
        final singleName = state.singleWhere((element) => element.id == id);
        names.add(singleName.name);
      } catch (e) {
        // Fluttertoast.showToast(msg: 'No Category Found');
        debugPrint('$id not found in category');
      }
    }
    return names;
  }

  /// Go to categories Page
  void goToCategoriesPage(BuildContext context, int id) {
    final data = state.where((element) => element.id == id);
    if (data.isNotEmpty) {
      final index = state.indexOf(data.first);
      final arguments = CategoryPageArguments(
        category: data.first,
        backgroundImage: index < AppImagesConfig.categoriesImages.length
            ? AppImagesConfig.categoriesImages[index]
            : AppImagesConfig.defaultCategoryImage,
      );
      Navigator.pushNamed(
        context,
        AppRoutes.category,
        arguments: arguments,
      );
    }
  }
}
