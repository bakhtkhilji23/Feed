import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/constants.dart';
import '../data/onboarding_model.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    Key? key,
    required this.data,
  }) : super(key: key);

  final OnboardingModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding * 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(data.imageLocation,height: MediaQuery.of(context).size.height * 0.23,fit: BoxFit.fitHeight),
          // Expanded(
          //   child: Lottie.asset(
          //     data.imageLocation,
          //     frameRate: FrameRate.max,
          //     fit: BoxFit.contain,
          //     addRepaintBoundary: false,
          //     options: LottieOptions(enableMergePaths: true),
          //   ),
          // ),
          AppSizedBox.h15,
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
            child: Column(
              children: [
                AutoSizeText(
                  data.title,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
                AppSizedBox.h15,
                Text(
                  data.description,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
