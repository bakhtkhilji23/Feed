import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../core/constants/constants.dart';

import '../../core/components/country_flag.dart';
import '../../core/components/select_theme_mode.dart';
import '../../core/localization/app_locales.dart';
import '../../core/routes/app_routes.dart';

class SelectLanguageAndThemePage extends StatelessWidget {
  const SelectLanguageAndThemePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SelectLanguage(),
              const Divider(),
              AppSizedBox.h10,
              const SelectThemeMode(),
              Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.loginIntro),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('done'.tr()),
                        const Icon(IconlyLight.arrowRight2)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'select_language'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              InkWell(
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.loginIntro,
                  (v) => false,
                ),
                borderRadius: AppDefaults.borderRadius,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('skip'.tr(),
                          style: Theme.of(context).textTheme.caption),
                      const Icon(IconlyLight.arrowRight2),
                    ],
                  ),
                ),
              ),
            ],
          ),
          AppSizedBox.h16,

          /// All Languages
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: AppLocales.supportedLocales.length,
            itemBuilder: (context, index) {
              Locale current = AppLocales.supportedLocales[index];
              return ListTile(
                onTap: () async {
                  await context.setLocale(current);
                },
                title: Text(AppLocales.formattedLanguageName(current)),
                leading: CountryFlag(countryCode: current.countryCode ?? 'AD'),
                trailing: context.locale == current
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : const SizedBox(),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }
}
