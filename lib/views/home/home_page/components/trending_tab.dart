import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/ad_config.dart';
import '../../../../core/components/banner_ad.dart';
import '../../../../core/components/headline_with_row.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/controllers/posts/feature_post_controller.dart';
import '../../../../core/controllers/posts/recent_posts_controller.dart';
import '../../../../core/models/article.dart';
import '../../../../core/utils/responsive.dart';
import 'popular_posts_list.dart';
import 'post_slider.dart';
import 'post_slider_tablet.dart';
import 'recent_post_list.dart';

class TrendingTabSection extends ConsumerWidget {
  const TrendingTabSection({
    Key? key,
    required this.featuredPosts,
  }) : super(key: key);
  final List<ArticleModel> featuredPosts;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).cardColor,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(featurePostController);
          await ref.read(recentPostController.notifier).onRefresh();
        },
        child: CustomScrollView(
          slivers: [
            /* <---- Featured News -----> */
            SliverPadding(
              padding: const EdgeInsets.only(top: AppDefaults.padding),
              sliver: SliverToBoxAdapter(
                child: Responsive(
                  mobile: PostSlider(articles: featuredPosts),
                  tablet: PostSliderTablet(articles: featuredPosts),
                ),
              ),
            ),
            if (AdConfig.isAdOn)
              const SliverToBoxAdapter(
                child: BannerAdWidget(),
              ),
            /* <---- Popular News -----> */
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
                child: HeadlineRow(
                  headline: 'popular_posts',
                  isHeader: false,
                ),
              ),
            ),
            const PopularPostFetcherSection(),
            const SliverToBoxAdapter(child: Divider()),
            /* <---- Recent News -----> */
            if (AdConfig.isAdOn)
              const SliverToBoxAdapter(
                child: BannerAdWidget(),
              ),
            // AppSizedBox.h16,
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDefaults.padding,
                ),
                child: HeadlineRow(
                  headline: 'recent_news',
                  isHeader: false,
                ),
              ),
            ),
            const RecentPostFetcherSection(),
          ],
        ),
      ),
    );
  }
}
