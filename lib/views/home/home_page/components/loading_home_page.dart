import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../config/wp_config.dart';
import '../../../../core/components/app_shimmer.dart';
import '../../../../core/components/headline_with_row.dart';
import '../../../../core/constants/constants.dart';
import 'loading_posts_responsive.dart';

class LoadingHomePage extends StatelessWidget {
  const LoadingHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            childAnimationBuilder: (child) => SlideAnimation(child: child),
            children: [
              AppBar(
                title: Text(WPConfig.appName),
                titleTextStyle: Theme.of(context).textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(IconlyLight.search),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(IconlyLight.notification),
                  ),
                ],
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(AppDefaults.padding / 2),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    5,
                    (index) => const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Chip(label: Text('hhhh gekg')),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(AppDefaults.margin),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppDefaults.borderRadius,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
                child: HeadlineRow(
                  headline: 'recent_news',
                  isHeader: false,
                ),
              ),
              const LoadingPostsResponsive(isEnabled: false, isInSliver: false),
            ],
          ),
        ),
      ),
    );
  }
}
