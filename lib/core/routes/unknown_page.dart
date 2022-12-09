import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../constants/constants.dart';
import 'app_routes.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.illustrationError),
          AppSizedBox.h16,
          AppSizedBox.h16,
          Text(
            'Oops! No Page found with this name',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
          ),
          AppSizedBox.h16,
          Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.entryPoint);
                },
                label: Text('go_back'.tr()),
                icon: const Icon(IconlyLight.arrowLeft),
              ),
            ),
          )
        ],
      ),
    );
  }
}
