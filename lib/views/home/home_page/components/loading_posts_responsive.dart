import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/components/dummy_article_tile.dart';
import '../../../../core/components/dummy_article_tile_large.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/responsive.dart';

class LoadingPostsResponsive extends StatelessWidget {
  const LoadingPostsResponsive({
    Key? key,
    this.isInSliver = true,
    this.isEnabled = true,
  }) : super(key: key);

  final bool isInSliver;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    if (isInSliver) {
      return SliverToBoxAdapter(
        child: Responsive(
          mobile: _MobileLoadingList(isEnabled: isEnabled),
          tablet: _TabletLoadingList(isEnabled: isEnabled),
          tabletPortrait: _TabletPortraitLoadingList(isEnabled: isEnabled),
        ),
      );
    } else {
      return Responsive(
        mobile: _MobileLoadingList(isEnabled: isEnabled),
        tablet: _TabletLoadingList(isEnabled: isEnabled),
        tabletPortrait: _TabletPortraitLoadingList(isEnabled: isEnabled),
      );
    }
  }
}

class _MobileLoadingList extends StatelessWidget {
  const _MobileLoadingList({
    Key? key,
    required this.isEnabled,
  }) : super(key: key);

  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: AppDefaults.padding / 2,
          horizontal: AppDefaults.padding,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: index == 2
                  ? DummyArticleTileLarge(isEnabled: isEnabled)
                  : DummyArticleTile(isEnabled: isEnabled),
            ),
          );
        }),
        itemCount: 3,
      ),
    );
  }
}

class _TabletLoadingList extends StatelessWidget {
  const _TabletLoadingList({
    Key? key,
    required this.isEnabled,
  }) : super(key: key);

  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.2,
          crossAxisSpacing: AppDefaults.margin,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          vertical: AppDefaults.padding / 2,
          horizontal: AppDefaults.padding,
        ),
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 3,
            child:
                SlideAnimation(child: DummyArticleTile(isEnabled: isEnabled)),
          );
        },
        itemCount: 12,
      ),
    );
  }
}

class _TabletPortraitLoadingList extends StatelessWidget {
  const _TabletPortraitLoadingList({
    Key? key,
    required this.isEnabled,
  }) : super(key: key);

  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.2,
          crossAxisSpacing: AppDefaults.margin,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          vertical: AppDefaults.padding / 2,
          horizontal: AppDefaults.padding,
        ),
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 2,
            child:
                SlideAnimation(child: DummyArticleTile(isEnabled: isEnabled)),
          );
        },
        itemCount: 12,
      ),
    );
  }
}
