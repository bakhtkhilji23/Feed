import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/app_defaults.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({
    Key? key,
    required this.icon,
    required this.iconColor,
    this.trailing,
    required this.label,
    this.onTap,
    this.subLabel,
    this.lastItem = false,
    this.shouldTranslate = true,
    this.isFaIcon = false,
  }) : super(key: key);

  final IconData icon;
  final Color iconColor;
  final Widget? trailing;
  final String label;
  final String? subLabel;
  final void Function()? onTap;
  final bool shouldTranslate;
  final bool isFaIcon;

  /// if true, you won't see the line in bottom
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDefaults.padding,
          vertical: AppDefaults.padding / 2,
        ),
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(shape: BoxShape.circle, color: iconColor),
          child: isFaIcon
              ? FaIcon(
                  icon,
                  color: Colors.white,
                )
              : Icon(
                  icon,
                  color: Colors.white,
                ),
        ),
        title: shouldTranslate ? Text(label.tr()) : Text(label),
        subtitle: subLabel == null ? null : shouldTranslate ? Text(subLabel?.tr() ?? '') : Text(subLabel ?? ''),
        trailing: trailing,
      ),
    );
  }
}
