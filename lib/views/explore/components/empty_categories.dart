import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

class EmptyCategoriesList extends StatelessWidget {
  const EmptyCategoriesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Image.asset(AppImages.emptyPost),
            ),
            AppSizedBox.h16,
            Text(
              'article_empty'.tr(),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'article_empty_message'.tr(),
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
      ),
    );
  }
}
