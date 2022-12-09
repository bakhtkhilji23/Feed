import 'package:flutter/material.dart';

import '../../../config/ad_config.dart';
import '../../components/article_tile.dart';
import '../../components/banner_ad.dart';
import '../../models/article.dart';
import '../../utils/responsive.dart';

class AdController {
  static List<Widget> getAdWithPosts(
    List<ArticleModel> posts, {
    bool isHeroDisabled = false,
    bool isMainPage = false,
    bool isSpecialSession = false,
  }) {
    final data = posts;
    final int every = AdConfig.adIntervalInCategory;

    final int size = data.length + data.length ~/ every;
    final List<Widget> items = List.generate(
      size,
      (i) {
        if (i != 0 && i % every == 0) {
          if (AdConfig.isAdOn) {
            return const BannerAdWidget();
          } else {
            return const _AdSpace();
          }
        } else {
          return ArticleTile(
              article: data[i - i ~/ every],
              isPopDisabled: true,
              isHeroDisabled: isHeroDisabled,
              isMainPage: isMainPage,
              isSpecialSession: isSpecialSession);
        }
      },
    );
    return items;
  }
}

class _AdSpace extends StatelessWidget {
  const _AdSpace({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const SizedBox(),
      tablet: Center(
        child: Text(
          'Advertisement Space',
          style: Theme.of(context).textTheme.caption,
        ),
      ),
      tabletPortrait: Center(
        child: Text(
          'Advertisement Space',
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }
}
