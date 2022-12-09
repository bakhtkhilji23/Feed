import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../config/wp_config.dart';
import '../../../core/components/app_logo.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/responsive.dart';

class LicenseDialog extends StatefulWidget {
  const LicenseDialog({Key? key}) : super(key: key);

  @override
  State<LicenseDialog> createState() => _LicenseDialogState();
}

class _LicenseDialogState extends State<LicenseDialog> {
  bool isGettingVersion = true;

  String? versionNumber;

  Future<void> _getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionNumber = packageInfo.version;
    isGettingVersion = false;
    setState(() {});
  }

  void _showLicensePage() {
    showLicensePage(
      context: context,
      applicationName: WPConfig.appName,
      applicationVersion: 'Version: $versionNumber',
      applicationLegalese:
          'In this app, we didn\'t used any proprietary libraries, everything is open sourced, if you have any questions, let us know.',
      applicationIcon: const Padding(
        padding: EdgeInsets.all(AppDefaults.padding),
        child: SizedBox(
          width: 80,
          height: 80,
          child: AppLogo(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getVersionNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: AppDefaults.borderRadius),
      child: SizedBox(
        width: Responsive.isMobile(context)
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * 0.3,
        child: Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 28,
                    height: 28,
                    child: AppLogo(),
                  ),
                  AppSizedBox.w10,
                  Text(
                    WPConfig.appName,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: AppColors.primary,
                        ),
                  )
                ],
              ),
              AppSizedBox.h16,
              if (isGettingVersion)
                const CircularProgressIndicator()
              else
                Text(
                  'Version: $versionNumber',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              AppSizedBox.h16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ),
                  AppSizedBox.w10,
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: _showLicensePage,
                      child: const AutoSizeText(
                        'View Licenses',
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
