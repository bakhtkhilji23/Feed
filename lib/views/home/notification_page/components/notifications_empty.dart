import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/responsive.dart';

class NotificationIsEmpty extends StatelessWidget {
  const NotificationIsEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Responsive(
            mobile: Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Image.asset(AppImages.notificationEmpty),
            ),
            tablet: SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: Image.asset(AppImages.notificationEmpty),
              ),
            ),
          ),
          AppSizedBox.h16,
          Text(
            'notification_empty'.tr(),
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'notification_empty_message'.tr(),
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.center,
            ),
          ),
          AppSizedBox.h16,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('go_back'.tr()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
