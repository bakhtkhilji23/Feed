import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../core/components/network_image.dart';
import '../../../core/controllers/category/categories_controller.dart';
import '../../../core/models/article.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/ui_util.dart';
import '../dialogs/want_to_delete.dart';

class SavedArticleTileTab extends StatelessWidget {
  const SavedArticleTileTab({
    Key? key,
    required this.index,
    required this.article,
    required this.animation,
  }) : super(key: key);

  final int index;
  final ArticleModel article;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDefaults.margin / 2,
        ),
        child: Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: AppDefaults.borderRadius,
          elevation: 1,
          borderOnForeground: false,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.post, arguments: article);
            },
            child: Column(
              children: [
                Row(
                  children: [
                    // thumbnail
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppDefaults.radius),
                          bottomLeft: Radius.circular(AppDefaults.radius),
                        ),
                        child: AspectRatio(
                          aspectRatio: 2 / 2,
                          child: Hero(
                            tag: article.heroTag,
                            child:
                                NetworkImageWithLoader(article.featuredImage),
                          ),
                        ),
                      ),
                    ),
                    // Description
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              article.title,
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 2,
                            ),

                            _CategoryWrap(article: article),

                            /// Date And Read Time
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          IconlyLight.closeSquare,
                                          color: AppColors.placeholder,
                                          size: 18,
                                        ),
                                        AppSizedBox.w5,
                                        Text(
                                          '${AppUtil.totalMinute(article.content, context)} Minute Read',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          IconlyLight.calendar,
                                          color: AppColors.placeholder,
                                          size: 18,
                                        ),
                                        AppSizedBox.w5,
                                        Text(
                                          DateFormat.yMMMMd(context.locale
                                                  .toLanguageTag())
                                              .format(article.date),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                /// Action Button
                                IconButton(
                                  onPressed: () {
                                    UiUtil.openDialog(
                                        context: context,
                                        widget: WantToDeleteSavedDialog(
                                          postID: article.id,
                                          index: index,
                                          articleModel: article,
                                        ));
                                  },
                                  icon: const Icon(IconlyLight.closeSquare),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryWrap extends StatelessWidget {
  const _CategoryWrap({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Consumer(
        builder: (context, ref, child) {
          final allCategories = ref
              .read(categoriesController.notifier)
              .categoriesName(article.categories);
          return Row(
            children: List.generate(
              allCategories.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: Chip(
                  backgroundColor: Theme.of(context).cardColor,
                  label: Html(
                    data: allCategories[index],
                    shrinkWrap: true,
                    style: {
                      'body': Style(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        fontSize: const FontSize(12.0),
                      ),
                      'figure': Style(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                      ),
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
