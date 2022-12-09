import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

class EmailSentSuccessfully extends StatelessWidget {
  const EmailSentSuccessfully({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: AppDefaults.borderRadius),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'message'.tr(),
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Divider(),
            AppSizedBox.h10,
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Image.asset(
                AppImages.emailSent,
              ),
            ),
            Text(
              'email_sent'.tr(),
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            AppSizedBox.h10,
            Text(
              'email_sent_message'.tr(),
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.center,
            ),
            AppSizedBox.h10,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text('verify'.tr()),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
