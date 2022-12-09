import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/constants.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({
    Key? key,
    required this.child,
    this.enabled = true,
  }) : super(key: key);

  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Theme.of(context).cardColor,
      baseColor: AppColors.primary.withOpacity(0.1),
      enabled: enabled,
      child: child,
    );
  }
}
