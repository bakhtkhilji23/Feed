import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../config/wp_config.dart';
import '../../../../core/components/app_video.dart';
import '../../../../core/components/banner_ad.dart';
import '../../../../core/components/network_image.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/models/article.dart';
import '../../../../core/utils/app_utils.dart';
import 'post_categories_name.dart';
import 'post_meta_data.dart';
import 'post_tags.dart';

class PostPageBody extends StatelessWidget {
  const PostPageBody({Key? key, required this.article}) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!article.tags.contains(WPConfig.videoTagID)) AppSizedBox.h16,

        /// Post Info
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: AnimationLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                childAnimationBuilder: (child) => SlideAnimation(
                  duration: AppDefaults.duration,
                  verticalOffset: 50.0,
                  horizontalOffset: 0,
                  child: child,
                ),
                children: [
                  FittedBox(
                    child: Html(
                      data: article.title,
                      style: {
                        'body': Style(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          fontSize: const FontSize(25.0),
                          lineHeight: const LineHeight(1.4),
                          fontWeight: FontWeight.bold,
                        ),
                        'figure': Style(
                            margin: EdgeInsets.zero, padding: EdgeInsets.zero),
                      },
                    ),
                  ),
                  AppSizedBox.h10,
                  PostMetaData(article: article),
                  PostCategoriesName(article: article),
                  const BannerAdWidget(),
                  ArticleHtmlConverter(article: article),
                  ArticleTags(article: article),
                  AppSizedBox.h15,
                  const BannerAdWidget(),
                ],
              ),
            ),
          ),
        ),

        AppSizedBox.h10,
        const Divider(height: 0),
      ],
    );
  }
}

class ArticleHtmlConverter extends StatelessWidget {
  const ArticleHtmlConverter({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: article.content,
      shrinkWrap: false,
      style: {
        'body': Style(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          fontSize: const FontSize(16.0),
          lineHeight: const LineHeight(1.4),
        ),
        'figure': Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
      },
      onImageTap: (String? url, RenderContext context1,
          Map<String, String> attributes, _) {
        if (url != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewImageFullScreen(url: url),
            ),
          );
        } else {
          Fluttertoast.showToast(msg: 'Can\'t find image link');
        }
      },
      customRender: {
        'video': (RenderContext renderContext, Widget child) {
          if (article.tags.contains(WPConfig.videoTagID)) {
            return const SizedBox();
          } else {
            return AppVideo(
              url: renderContext.tree.element!.attributes['src'].toString(),
            );
          }
        },
      },
      onLinkTap: (url, renderCtx, _, __) {
        if (url == null) {
          Fluttertoast.showToast(msg: 'Error parsing url');
        } else {
          AppUtil.openLink(url);
        }
      },
    );
  }
}

class ViewImageFullScreen extends StatelessWidget {
  const ViewImageFullScreen({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: InteractiveViewer(
          child: Hero(
            tag: url,
            child: NetworkImageWithLoader(
              url,
              radius: 0,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
