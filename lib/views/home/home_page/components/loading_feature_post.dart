import 'package:flutter/material.dart';

import '../../../../core/components/app_shimmer.dart';
import '../../../../core/components/dummy_article_tile_large.dart';
import '../../../../core/components/headline_with_row.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/responsive.dart';
import 'loading_posts_responsive.dart';
import 'post_slider.dart';
import 'post_slider_tablet.dart';

class LoadingFeaturePost extends StatelessWidget {
  const LoadingFeaturePost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            AppSizedBox.h16,
            Responsive(
              mobile: DummyPostSlider(),
              tablet: DummyPostSliderTablet(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: AppShimmer(
                child: HeadlineRow(
                  headline: 'popular_posts',
                  isHeader: false,
                ),
              ),
            ),
            LoadingPostsResponsive(isEnabled: false, isInSliver: false),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDefaults.padding,
              ),
              child: DummyArticleTileLarge(
                isEnabled: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
