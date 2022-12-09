import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../config/wp_config.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/models/category.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/theme_manager.dart';
import '../../../../core/utils/responsive.dart';

class HomeAppBarWithTab extends StatelessWidget {
  const HomeAppBarWithTab({
    Key? key,
    required this.categories,
    required this.tabController,
    required this.forceElevated,
  }) : super(key: key);

  final List<CategoryModel> categories;
  final TabController tabController;

  final bool forceElevated;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 1,
      pinned: true,
      floating: true,
      snap: true,
      automaticallyImplyLeading: false,
      forceElevated: forceElevated,
      title: WPConfig.showLogoInHomePage ? null : const Text(WPConfig.appName),
      titleTextStyle: Theme.of(context).textTheme.headline6?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
      // leading: IconButton(
      //   onPressed: () {},
      //   icon: const Icon(
      //     Icons.menu,
      //   ),
      // ),
      // WPConfig.showLogoInHomePage ? const HorizontalAppLogo() : null,
      leadingWidth: WPConfig.showLogoInHomePage
          ? Responsive.isMobile(context)
              ? MediaQuery.of(context).size.width * 0.15
              : MediaQuery.of(context).size.width * 0.15
          : null,

      actions: [
        IconButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
          icon: const Icon(IconlyLight.search),
        ),
        IconButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.notification),
          icon: const Icon(IconlyLight.notification),
        ),
      ],

      /// TabBar
      // bottom: TabBar(
      //   controller: tabController,
      //   enableFeedback: true,
      //   isScrollable: true,
      //   padding: const EdgeInsets.only(left: AppDefaults.padding),
      //   tabs: AnimationConfiguration.toStaggeredList(
      //     duration: const Duration(milliseconds: 375),
      //     childAnimationBuilder: (widget) => SlideAnimation(
      //       horizontalOffset: 50.0,
      //       child: FadeInAnimation(
      //         child: widget,
      //       ),
      //     ),
      //     children: List.generate(
      //       categories.length,
      //       (index) => Text(
      //         categories[index].name,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

class HorizontalAppLogo extends ConsumerWidget {
  const HorizontalAppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkMode(context));
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Image.asset(
        isDark ? AppImages.horizontalLogoDark : AppImages.horizontalLogo,
        fit: BoxFit.contain,
      ),
    );
  }
}
