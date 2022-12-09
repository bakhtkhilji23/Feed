import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../config/wp_config.dart';
import '../../core/components/app_logo.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/constants/sizedbox_const.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/ui_util.dart';
import '../entrypoint/entrypoint.dart';
import '../settings/dialogs/change_language.dart';
import 'components/dont_have_account_button.dart';

class LoginIntroPage extends StatelessWidget {
  const LoginIntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: Column(
            children: [
              /// Header
              const LoginIntroHeader(),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: Column(
                  children: [
                    Responsive(
                      mobile: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: const AppLogo(),
                      ),
                      tablet: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: const AppLogo(),
                      ),
                    ),
                    AppSizedBox.h16,
                    AppSizedBox.h16,
                    Text(
                      '${'welcome_newspro'.tr()} ${WPConfig.appName}',
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    Responsive(
                      mobile: Padding(
                        padding: const EdgeInsets.all(16),
                        child: AutoSizeText(
                          'welcome_message'.tr(),
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      tablet: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: AutoSizeText(
                            'welcome_message'.tr(),
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppDefaults.margin),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.login);
                    },
                    child: Text('sign_in_continue'.tr()),
                  ),
                ),
              ),
              const DontHaveAccountButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginIntroHeader extends StatelessWidget {
  const LoginIntroHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Change Locale Button
        IconButton(
          onPressed: () {
            UiUtil.openBottomSheet(
                context: context, widget: const ChangeLanguageDialog());
          },
          icon: const Icon(Icons.language_rounded),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const EntryPointUI()),
              (v) => false,
            );
          },
          child: Text('skip'.tr()),
        ),
      ],
    );
  }
}
