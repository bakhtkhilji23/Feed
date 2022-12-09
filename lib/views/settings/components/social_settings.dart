import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../config/wp_config.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/app_utils.dart';
import 'setting_list_tile.dart';

class SocialSettings extends StatelessWidget {
  const SocialSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppDefaults.margin),
          child: Text(
            'social'.tr(),
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        SettingTile(
          label: 'contact_us',
          icon: Icons.contact_mail_rounded,
          iconColor: Colors.blueGrey,
          trailing: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(IconlyLight.arrowRight2),
          ),
          onTap: () {
            const url = WPConfig.supportEmail;
            if (url.isNotEmpty) {
              AppUtil.launchUrl('mailto:$url');
            } else {
              Fluttertoast.showToast(msg: 'No App Url link provided');
            }
          },
        ),
        SettingTile(
          label: 'Website',
          shouldTranslate: false,
          icon: FontAwesomeIcons.earthAsia,
          isFaIcon: true,
          iconColor: Colors.green,
          trailing: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(IconlyLight.arrowRight2),
          ),
          onTap: () {
            const url = WPConfig.url;
            if (url.isNotEmpty) {
              AppUtil.openLink('https://$url');
            } else {
              Fluttertoast.showToast(msg: 'No App Url link provided');
            }
          },
        ),
        if (WPConfig.facebookUrl.isNotEmpty)
          SettingTile(
            label: 'Facebook',
            icon: FontAwesomeIcons.facebook,
            shouldTranslate: false,
            isFaIcon: true,
            iconColor: Colors.blue,
            trailing: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(IconlyLight.arrowRight2),
            ),
            onTap: () {
              const url = WPConfig.facebookUrl;
              if (url.isNotEmpty) {
                AppUtil.openLink(url);
              } else {
                Fluttertoast.showToast(msg: 'No Facebook link provided');
              }
            },
          ),
        if (WPConfig.youtubeUrl.isNotEmpty)
          SettingTile(
            label: 'Youtube',
            shouldTranslate: false,
            icon: FontAwesomeIcons.youtube,
            isFaIcon: true,
            iconColor: Colors.red,
            trailing: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(IconlyLight.arrowRight2),
            ),
            onTap: () {
              const url = WPConfig.youtubeUrl;
              if (url.isNotEmpty) {
                AppUtil.openLink(url);
              } else {
                Fluttertoast.showToast(msg: 'No Youtube link provided');
              }
            },
          ),
        if (WPConfig.twitterUrl.isNotEmpty)
          SettingTile(
            label: 'Twitter',
            shouldTranslate: false,
            icon: FontAwesomeIcons.twitter,
            isFaIcon: true,
            iconColor: Colors.lightBlue,
            trailing: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(IconlyLight.arrowRight2),
            ),
            onTap: () {
              const url = WPConfig.twitterUrl;
              if (url.isNotEmpty) {
                AppUtil.openLink(url);
              } else {
                Fluttertoast.showToast(msg: 'No Twitter link provided');
              }
            },
          ),
      ],
    );
  }
}
