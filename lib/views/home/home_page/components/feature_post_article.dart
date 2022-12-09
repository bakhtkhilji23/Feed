import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../../core/components/network_image.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/models/article.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/utils/responsive.dart';

class FeaturedPostArticle extends StatelessWidget {
  const FeaturedPostArticle({
    Key? key,
    required this.onTap,
    required this.isActive,
    required this.article,
  }) : super(key: key);

  final void Function() onTap;
  final bool isActive;
  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: AppDefaults.duration,
      padding: EdgeInsets.symmetric(
        horizontal: AppDefaults.padding / 2,
        vertical: isActive ? 8.0 : 16,
      ),
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppDefaults.duration,
          decoration: BoxDecoration(
            borderRadius: AppDefaults.borderRadius,
            boxShadow: [
              AppDefaults.boxShadow.first,
              AppDefaults.boxShadow.first,
            ],
          ),
          child: Stack(
            children: [
              Hero(
                tag: article.heroTag,
                child: NetworkImageWithLoader(article.featuredImage),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: AnimatedContainer(
                  duration: AppDefaults.duration,
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  decoration: BoxDecoration(
                    borderRadius: AppDefaults.topSheetRadius,
                    color: AppColors.scaffoldBackgrounDark.withOpacity(0.6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Html(
                          data: article.title,
                          style: {
                            'body': Style(
                              margin: EdgeInsets.zero,
                              padding: EdgeInsets.zero,
                              fontSize: Responsive.isTablet(context)
                                  ? const FontSize(32.0)
                                  : const FontSize(16.0),
                              lineHeight: const LineHeight(1.4),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              maxLines: 2,
                            ),
                            'figure': Style(
                                margin: EdgeInsets.zero,
                                padding: EdgeInsets.zero),
                          },
                        ),
                      ),
                      AppSizedBox.h10,
                      Row(
                        children: [
                          const Icon(
                            IconlyLight.timeCircle,
                            color: Colors.white,
                          ),
                          AppSizedBox.w10,
                          Text(
                            '${AppUtil.totalMinute(article.content, context)}  ${'minute_read'.tr()} | ${DateFormat.yMMMMd(context.locale.toLanguageTag()).format(article.date)}',
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: Colors.white70,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
