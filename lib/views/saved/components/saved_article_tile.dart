import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_pro/views/home/post_page/components/save_post_button.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/constants.dart';
import '../../../core/components/network_image.dart';
import '../../../core/controllers/category/categories_controller.dart';
import '../../../core/models/article.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/ui_util.dart';
import '../dialogs/want_to_delete.dart';

class SavedArticleTile extends StatelessWidget {
  const SavedArticleTile({
    Key? key,
    required this.index,
    required this.article,
    required this.animation,
    required this.onRefresh,
  }) : super(key: key);

  final int index;
  final ArticleModel article;
  final Animation<double> animation;
  final Function onRefresh;

  @override
  Widget build(BuildContext context) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    final plain = article.content.replaceAll(exp, '');
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  article.title,
                  style: const TextStyle(
                      fontFamily: 'Freight',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                'assets/icons/clock.svg',
                width: 20,
                height: 20,
                color: Color(0xff006199),
              ),
              const SizedBox(width: 5),
              Text(
                DateFormat.yMMMd().format(article.date),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Freight',
                ),
              ),
              const SizedBox(width: 18),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              // if (isPopDisabled == false) {
              //   Navigator.pushNamedAndRemoveUntil(
              //     context,
              //     AppRoutes.post,
              //     (v) => v.isFirst,
              //     arguments: article,
              //   );
              // }
              // else {
              Navigator.pushNamed(
                context,
                AppRoutes.post,
                arguments: article,
              );
              // }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  // borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    article.featuredImage,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // const SizedBox(
                //   height: 2,
                // ),

                // FittedBox(
                //   child: Html(
                //     data: article.content,
                //     style: {
                //       'body': Style(
                //         margin: EdgeInsets.zero,
                //         padding: EdgeInsets.zero,
                //         fontSize: _articleTileFont(context),
                //         lineHeight: const LineHeight(1.4),
                //         fontWeight: FontWeight.bold,
                //         maxLines: 3,
                //         textOverflow: TextOverflow.ellipsis,
                //       ),
                //       'figure':
                //           Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
                //     },
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                if (plain.length > 199) ...[
                  SizedBox(
                    height: 35,
                    child: Text(
                      '${plain.substring(0, 85)}...',
                      style: TextStyle(
                        //overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                        height: 0,
                      ),
                    ),
                  ),
                ] else
                  Text(
                    '${plain.substring(0, 1)}',
                    style: TextStyle(
                      height: 0,
                      //overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SavePostButton(
                  article: article,
                  disabledColor: Colors.grey,
                  postSaveCallback: () {
                    onRefresh();
                  }),
              const SizedBox(
                width: 20,
              ),
              // const Text(
              //   '247',
              //   style: TextStyle(fontSize: 15, color: Colors.red),
              // ),
              // const SizedBox(
              //   width: 40,
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.comment,
                      arguments: article);
                },
                child: Image.asset('assets/icons/comment.png',
                    width: 20, height: 20, color: Colors.blue),
              ),
              const SizedBox(
                width: 20,
              ),
              // const Text(
              //   '57',
              //   style: TextStyle(fontSize: 15, color: Colors.teal),
              // ),
              // const SizedBox(
              //   width: 40,
              // ),
              GestureDetector(
                onTap: () async => await Share.share(article.link),
                child: SvgPicture.asset(
                  'assets/icons/share.svg',
                  width: 20,
                  height: 20,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              // const Text(
              //   '33',
              //   style: TextStyle(fontSize: 15, color: Colors.teal),
              // ),
              const Spacer()
            ],
          ),
        ],
      ),
    );

    SizeTransition(
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
                      flex: 3,
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
                      flex: 4,
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
