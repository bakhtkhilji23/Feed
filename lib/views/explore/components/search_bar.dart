import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.search);
          },
          icon: const Icon(IconlyLight.search),
          label: Text('search_field'.tr()),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).cardColor,
            elevation: 0,
            onPrimary: AppColors.placeholder,
            splashFactory: InkRipple.splashFactory,
          ),
        ),
      ),
    );
  }
}
