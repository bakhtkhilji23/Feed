import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/constants.dart';
import '../themes/theme_manager.dart';

class SelectThemeMode extends ConsumerWidget {
  const SelectThemeMode({
    Key? key,
    this.backgroundColor,
  }) : super(key: key);

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final controller = ref.read(themeModeProvider.notifier);
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'select_theme'.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppDefaults.padding),
              child: Row(
                children: [
                  Expanded(
                    child: _ThemeModeSelector(
                      backgroundColor: AppColors.primary,
                      icon: Icons.phone_android,
                      isActive: themeMode == AdaptiveThemeMode.system,
                      themeName: 'System',
                      onTap: () {
                        controller.changeThemeMode(
                            AdaptiveThemeMode.system, context);
                      },
                    ),
                  ),
                  AppSizedBox.w16,
                  Expanded(
                    child: _ThemeModeSelector(
                      backgroundColor: Colors.orangeAccent,
                      icon: Icons.light_mode_rounded,
                      isActive: themeMode == AdaptiveThemeMode.light,
                      themeName: 'Light',
                      onTap: () {
                        controller.changeThemeMode(
                            AdaptiveThemeMode.light, context);
                      },
                    ),
                  ),
                  AppSizedBox.w16,
                  Expanded(
                    child: _ThemeModeSelector(
                      backgroundColor: Colors.black87,
                      icon: Icons.dark_mode_rounded,
                      isActive: themeMode == AdaptiveThemeMode.dark,
                      themeName: 'Dark',
                      onTap: () {
                        controller.changeThemeMode(
                            AdaptiveThemeMode.dark, context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ThemeModeSelector extends StatelessWidget {
  const _ThemeModeSelector({
    Key? key,
    required this.isActive,
    required this.themeName,
    required this.backgroundColor,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final bool isActive;
  final String themeName;
  final Color backgroundColor;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: AppDefaults.borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppDefaults.borderRadius,
        child: Stack(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(AppDefaults.padding),
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    Icon(
                      icon,
                      color: Colors.white,
                    ),
                    AppSizedBox.h10,
                    Text(
                      themeName,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: AnimatedOpacity(
                opacity: isActive ? 1 : 0,
                duration: AppDefaults.duration,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          AppDefaults.radius,
                        ),
                        bottomLeft: Radius.circular(
                          AppDefaults.radius,
                        ),
                      )),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
