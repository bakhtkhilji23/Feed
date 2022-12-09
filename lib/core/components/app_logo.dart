import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/constants.dart';
import '../themes/theme_manager.dart';

/// Dynamic App Logo Based on Theme
class AppLogo extends ConsumerWidget {
  const AppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkMode(context));
    if (isDark) {
      return Image.asset(AppImages.appLogoDark);
    } else {
      return Image.asset(AppImages.appLogo);
    }
  }
}
