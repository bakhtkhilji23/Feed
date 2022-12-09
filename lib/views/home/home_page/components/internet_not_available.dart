import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/constants.dart';

class InternetNotAvailablePage extends StatelessWidget {
  const InternetNotAvailablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Internet Available',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Lottie.asset('assets/animations/no_internet_animation.json'),
          ),
          const SizedBox(height: AppDefaults.margin),
          Text(
            'Currently you don\'t have internet available',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Please open your settings and enable internet by turning wifi or mobile data',
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDefaults.margin),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  AppSettings.openWIFISettings();
                },
                child: const Text('Open Settings'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
