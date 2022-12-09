import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_defaults.dart';
import '../../../../core/controllers/tags/tags_controller.dart';
import '../../../../core/models/article.dart';
import '../../../../core/routes/app_routes.dart';

class ArticleTags extends ConsumerWidget {
  const ArticleTags({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(tagsProvider(article.tags));
    return tags.map(
      data: (data) {
        return Wrap(
          spacing: AppDefaults.padding / 2,
          children: List.generate(
            data.value.length,
            (index) => InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.tag,
                  arguments: data.value[index],
                );
              },
              borderRadius: AppDefaults.borderRadius,
              child: Chip(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                label: Text(
                  '#${data.value[index].name}',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
          ),
        );
      },
      error: (e) => Text(e.toString()),
      loading: (e) => const CircularProgressIndicator(),
    );
  }
}
