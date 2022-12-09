import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget? tabletPortrait;

  const Responsive(
      {Key? key,
      required this.mobile,
      required this.tablet,
      this.tabletPortrait})
      : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, help us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 850;

  static bool isTabletPortrait(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width <= 850;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width >= 768 && size.width <= 850 && tabletPortrait != null) {
      return tabletPortrait!;
    }
    // If width is more then 850 we consider it as tablet
    else if (size.width >= 850) {
      return tablet;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}
