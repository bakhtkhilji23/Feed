import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_pro/views/home/post_page/components/save_post_button.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/constants.dart';
import '../controllers/category/categories_controller.dart';
import '../models/article.dart';
import '../routes/app_routes.dart';
import '../utils/responsive.dart';

class ArticleTile extends ConsumerWidget {
  const ArticleTile({
    Key? key,
    required this.article,
    this.isHeroDisabled = false,
    this.isPopDisabled = false,
    this.isMainPage = false,
    this.isSpecialSession = false,
  }) : super(key: key);

  final ArticleModel article;
  final bool isSpecialSession;

  /// This is for so that we will have a unique hero Tag to animate
  /// otherwise we will face Hero animation issues
  final bool isHeroDisabled;
  final bool isPopDisabled;
  final bool isMainPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    var plain = article.content.replaceAll(exp, '');
    String title = plain.substring(0, 50);
    print('===>>>${plain.length}');
    print('===>>>${plain.substring(0, 50).length}');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 180,
                child: Text(
                  article.title,
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Freight',
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              const Spacer(),
              Row(
                children: [
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
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              // const SizedBox(width: 20),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              if (isPopDisabled == false) {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.post, (v) => v.isFirst,
                    arguments: [article, isSpecialSession]);
              } else {
                Navigator.pushNamed(context, AppRoutes.post,
                    arguments: [article, isSpecialSession]);
              }
            },
            child: Column(
              children: [
                ClipRRect(
                  clipBehavior: Clip.none,
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    article.featuredImage,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // FittedBox(
                //   child: Html(
                //     data: article.content,
                //     style: {
                //       'body': Style(
                //         margin: EdgeInsets.zero,
                //         padding: EdgeInsets.zero,
                //         fontSize: _articleTileFont(context),
                //         lineHeight: const LineHeight(1.4),
                //         maxLines: 2,
                //         textOverflow: TextOverflow.ellipsis,
                //       ),
                //       'figure': Style(
                //           margin: EdgeInsets.zero, padding: EdgeInsets.zero),
                //     },
                //   ),
                // ),

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
            height: 15,
          ),
          Row(
            children: [
              SavePostButton(
                article: article,
                disabledColor: Colors.grey,
              ),
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
                    width: 20, height: 20, color: Color(0xff278EAD)),
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
                  color: Color(0xff278EAD),
                ),
              ),
              // const SizedBox(
              //   width: 20,
              // ),
              // const Text(
              //   '33',
              //   style: TextStyle(fontSize: 15, color: Colors.teal),
              // ),
              // const Spacer()
            ],
          ),
        ],
      ),
    );

    //     Padding(
    //   padding: const EdgeInsets.symmetric(vertical: AppDefaults.margin / 2),
    //   child: Material(
    //     color: isMainPage
    //         ? Theme.of(context).scaffoldBackgroundColor
    //         : Theme.of(context).canvasColor,
    //     borderRadius: AppDefaults.borderRadius,
    //     child: InkWell(
    //       onTap: () {
    //         if (isPopDisabled == false) {
    //           Navigator.pushNamedAndRemoveUntil(
    //             context,
    //             AppRoutes.post,
    //             (v) => v.isFirst,
    //             arguments: article,
    //           );
    //         } else {
    //           Navigator.pushNamed(
    //             context,
    //             AppRoutes.post,
    //             arguments: article,
    //           );
    //         }
    //       },
    //       borderRadius: AppDefaults.borderRadius,
    //       child: Container(
    //         decoration: BoxDecoration(
    //           boxShadow: AppDefaults.boxShadow,
    //         ),
    //         child: Row(
    //           children: [
    //             // thumbnail
    //             Expanded(
    //               flex: 3,
    //               child: isHeroDisabled
    //                   ? VideoArticleWrapper(
    //                       isVideoArticle:
    //                           article.tags.contains(WPConfig.videoTagID),
    //                       child: ClipRRect(
    //                         borderRadius: const BorderRadius.only(
    //                           topLeft: Radius.circular(AppDefaults.radius),
    //                           bottomLeft: Radius.circular(AppDefaults.radius),
    //                         ),
    //                         child: AspectRatio(
    //                           aspectRatio: 2 / 2,
    //                           child:
    //                               NetworkImageWithLoader(article.featuredImage),
    //                         ),
    //                       ),
    //                     )
    //                   : VideoArticleWrapper(
    //                       isVideoArticle:
    //                           article.tags.contains(WPConfig.videoTagID),
    //                       child: Hero(
    //                         tag: article.heroTag,
    //                         child: ClipRRect(
    //                           borderRadius: const BorderRadius.only(
    //                             topLeft: Radius.circular(AppDefaults.radius),
    //                             bottomLeft: Radius.circular(AppDefaults.radius),
    //                           ),
    //                           child: AspectRatio(
    //                             aspectRatio: 2 / 2,
    //                             child: NetworkImageWithLoader(
    //                                 article.featuredImage),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //             ),
    //             // Description
    //             Expanded(
    //               flex: 4,
    //               child: Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     FittedBox(
    //                       child: Html(
    //                         data: article.title,
    //                         style: {
    //                           'body': Style(
    //                             margin: EdgeInsets.zero,
    //                             padding: EdgeInsets.zero,
    //                             fontSize: _articleTileFont(context),
    //                             lineHeight: const LineHeight(1.4),
    //                             fontWeight: FontWeight.bold,
    //                             maxLines: 3,
    //                             textOverflow: TextOverflow.ellipsis,
    //                           ),
    //                           'figure': Style(
    //                               margin: EdgeInsets.zero,
    //                               padding: EdgeInsets.zero),
    //                         },
    //                       ),
    //                     ),

    //                     /* <---- Category List -----> */
    //                     _CategoryWrap(article: article),
    //                     Row(
    //                       children: [
    //                         const Icon(
    //                           IconlyLight.timeCircle,
    //                           color: AppColors.placeholder,
    //                           size: 18,
    //                         ),
    //                         AppSizedBox.w5,
    //                         Text(
    //                           '${AppUtil.totalMinute(article.content, context)} ${'minute_read'.tr()}',
    //                           style: Theme.of(context).textTheme.caption,
    //                         ),
    //                       ],
    //                     ),
    //                     AppSizedBox.h5,
    //                     Row(
    //                       children: [
    //                         const Icon(
    //                           IconlyLight.calendar,
    //                           color: AppColors.placeholder,
    //                           size: 18,
    //                         ),
    //                         AppSizedBox.w5,
    //                         Text(
    //                           DateFormat.yMMMMd(context.locale.toLanguageTag())
    //                               .format(article.date),
    //                           style: Theme.of(context).textTheme.caption,
    //                         ),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  FontSize _articleTileFont(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return const FontSize(25);
    } else if (Responsive.isTabletPortrait(context)) {
      return const FontSize(48);
    } else if (Responsive.isTablet(context)) {
      return const FontSize(65);
    } else {
      return const FontSize(25);
    }
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
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  label: AutoSizeText(
                    allCategories[index],
                    style: Theme.of(context).textTheme.caption,
                  ),
                  side: const BorderSide(
                    width: 0.2,
                    color: AppColors.cardColor,
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

class VideoArticleWrapper extends StatelessWidget {
  const VideoArticleWrapper({
    Key? key,
    required this.isVideoArticle,
    required this.child,
  }) : super(key: key);

  final bool isVideoArticle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isVideoArticle)
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: AppDefaults.borderRadius,
                ),
                child: const Icon(
                  Icons.play_circle,
                  color: Colors.white,
                  size: 56,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
