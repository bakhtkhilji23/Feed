import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/controllers/category/categories_controller.dart';
import '../../../../core/models/article.dart';

class PostCategoriesName extends StatelessWidget {
  const PostCategoriesName({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final allCategories = ref
            .read(categoriesController.notifier)
            .categoriesName(article.categories);
        return Wrap(
          spacing: 8.0,
          children: AnimationConfiguration.toStaggeredList(
            childAnimationBuilder: (child) => SlideAnimation(
              horizontalOffset: 0,
              verticalOffset: 50,
              child: child,
            ),
            children: List.generate(
              allCategories.length,
              (index) => InkWell(
                onTap: () {
                  final categories = ref.read(categoriesController.notifier);
                  categories.goToCategoriesPage(
                      context, article.categories[index]);
                },
                child: Chip(
                  padding: const EdgeInsets.all(4.0),
                  labelStyle: Theme.of(context).textTheme.caption,
                  backgroundColor: Theme.of(context).cardColor,
                  label: Html(
                    data: allCategories[index],
                    shrinkWrap: true,
                    style: {
                      'body': Style(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        fontSize: const FontSize(12.0),
                        lineHeight: const LineHeight(1.4),
                      ),
                      'figure': Style(
                          margin: EdgeInsets.zero, padding: EdgeInsets.zero),
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
