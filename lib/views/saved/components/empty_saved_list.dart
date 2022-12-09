import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/responsive.dart';

class EmptySavedList extends StatelessWidget {
  const EmptySavedList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding * 2),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Responsive(
              mobile: Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: Image.asset(AppImages.savedPostEmpty),
              ),
              tablet: SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: Image.asset(AppImages.savedPostEmpty),
                ),
              ),
            ),
            AppSizedBox.h16,
            Text(
              'saved_article_empty'.tr(),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'saved_article_empty_message'.tr(),
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
