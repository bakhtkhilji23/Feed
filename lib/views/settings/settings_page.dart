import 'package:flutter/material.dart';
import 'package:news_pro/config/wp_config.dart';

import '../../core/components/headline_with_row.dart';
import '../../core/constants/app_defaults.dart';
import 'components/all_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: WPConfig.primaryColor,
          title: HeadlineRow(headline: 'settings'),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              /// Settings
              AllSettings(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
