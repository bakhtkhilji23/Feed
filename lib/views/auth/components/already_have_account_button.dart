import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';

class AlreadyHaveAccountButton extends StatelessWidget {
  const AlreadyHaveAccountButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('already_have_account'.tr()),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.login);
              },
              child: const Text('login').tr())
        ],
      ),
    );
  }
}
