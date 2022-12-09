import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';

class DontHaveAccountButton extends StatelessWidget {
  const DontHaveAccountButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('dont_have_account'.tr()),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.signup);
              },
              child: Text('sign_up'.tr()))
        ],
      ),
    );
  }
}
