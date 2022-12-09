import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';
import '../explore/explore_page.dart';
import '../home/home_page/home_page.dart';
import '../saved/saved_page.dart';
import '../settings/settings_page.dart';

class EntryPointUI extends StatefulWidget {
  // final int? index;
  const EntryPointUI({Key? key}) : super(key: key);

  @override
  State<EntryPointUI> createState() => _EntryPointUIState();
}

class _EntryPointUIState extends State<EntryPointUI> {
  late PageController _controller;

  int _selectedIndex = 0;

  onTabTap(int index) {
    _controller.animateToPage(
      index,
      duration: AppDefaults.duration,
      curve: Curves.ease,
    );
    _selectedIndex = index;
    setState(() {});
  }

  final screens = const [
    HomePage(),
    ExplorePage(),
    SavedPage(),
    SettingsPage(),
  ];

  Future<bool> _onPop() async {
    int currentPage = _controller.page?.round() ?? 0;
    if (currentPage != 0) {
      _controller.animateToPage(0,
          duration: AppDefaults.duration, curve: Curves.ease);
      _selectedIndex = 0;
      setState(() {});
      return false;
    } else {
      await SystemNavigator.pop();
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    // if (widget.index != null) {
    //   _selectedIndex = widget.index!;
    //   setState(() {});
    // }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navbarItems = [
      GButton(icon: IconlyLight.home, text: 'home'.tr()),
      GButton(icon: IconlyLight.category, text: 'explore'.tr()),
      GButton(icon: IconlyLight.heart, text: 'saved'.tr()),
      GButton(icon: IconlyLight.profile, text: 'settings'.tr()),
    ];

    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
        body: PageView(
          allowImplicitScrolling: false,
          physics: const NeverScrollableScrollPhysics(),
          controller: _controller,
          children: screens,
        ),
        // bottomNavigationBar: SafeArea(
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: GNav(
        //       rippleColor: AppColors.primary.withOpacity(0.3),
        //       hoverColor: Colors.grey.shade700,
        //       haptic: true, // haptic feedback
        //       tabBorderRadius: AppDefaults.radius,
        //       curve: Curves.easeIn, // tab animation curves
        //       duration: AppDefaults.duration, // tab animation duration
        //       gap: 8,
        //       padding: const EdgeInsets.all(AppDefaults.padding),
        //       color: Colors.grey, // unselected icon color
        //       activeColor: AppColors.primary, // selected icon and text color
        //       iconSize: 24, // tab button icon size
        //       tabBackgroundColor: AppColors.primary.withOpacity(0.1),
        //       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //       tabs: navbarItems,
        //       onTabChange: onTabTap,
        //       selectedIndex: _selectedIndex,
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
