import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/app_utils.dart';
import 'setting_list_tile.dart';

class BuyAppSettings extends StatelessWidget {
  const BuyAppSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(AppDefaults.margin),
        ),
        SettingTile(
          label: 'buy_this_app',
          icon: IconlyLight.buy,
          iconColor: Colors.teal,
          trailing: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(IconlyLight.arrowRight2),
          ),
          onTap: () {
            const url =
                'https://codecanyon.net/item/newspro-flutter-news-app-for-wordpress/36550513';
            AppUtil.launchUrl(url);
          },
        ),
      ],
    );
  }
}
