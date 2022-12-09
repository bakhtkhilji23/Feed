import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/controllers/auth/auth_controller.dart';
import '../../../core/controllers/auth/auth_state.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/ui_util.dart';
import '../dialogs/delete_user.dart';
import 'setting_list_tile.dart';

class UserSettings extends ConsumerWidget {
  const UserSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(authController);
    if (authProvider is AuthLoggedIn) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDefaults.margin),
            child: Text(
              'account_settings'.tr(),
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          SettingTile(
            label: authProvider.member?.name ?? 'No Name Found',
            icon: IconlyLight.profile,
            iconColor: Colors.blue,
            shouldTranslate: false,
            //trailing: Icon(IconlyBold.edit),
            onTap: () {},
          ),
          SettingTile(
            label: authProvider.member?.email ?? 'No Email Found',
            icon: IconlyLight.message,
            iconColor: Colors.orangeAccent,
            shouldTranslate: false,
            //trailing: Icon(IconlyBold.edit),
            onTap: () {},
          ),
          SettingTile(
            label: 'Delete Account',
            icon: IconlyLight.delete,
            iconColor: Colors.red,
            shouldTranslate: false,
            onTap: () {
              UiUtil.openDialog(
                  context: context, widget: const DeleteUserDialog());
            },
          ),
          SettingTile(
            label: 'logout',
            icon: IconlyLight.logout,
            iconColor: Colors.redAccent,
            trailing: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(IconlyLight.arrowRight2),
            ),
            onTap: () {
              ref.read(authController.notifier).logout(context);
            },
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDefaults.margin),
            child: Text(
              'account_settings'.tr(),
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          SettingTile(
            label: 'login',
            icon: IconlyLight.logout,
            iconColor: AppColors.primary,
            trailing: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(IconlyLight.arrowRight2),
            ),
            onTap: () => Navigator.pushNamed(context, AppRoutes.loginIntro),
          ),
        ],
      );
    }
  }
}
