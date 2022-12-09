import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/responsive.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({
    Key? key,
    required this.title,
    required this.onSkip,
  }) : super(key: key);

  final String title;
  final void Function() onSkip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding / 2),
      child: Row(
        children: [
          // AppSizedBox.w10,
          // Responsive(
          //   mobile: Image.asset(
          //     AppImages.appLogo,
          //     width: MediaQuery.of(context).size.width * 0.06,
          //   ),
          //   tablet: Image.asset(
          //     AppImages.appLogo,
          //     width: MediaQuery.of(context).size.width * 0.03,
          //   ),
          // ),
          // AppSizedBox.w10,
          // Text(
          //   title,
          //   style: Theme.of(context).textTheme.headline6?.copyWith(
          //         color: AppColors.primary,
          //         fontWeight: FontWeight.bold,
          //       ),
          // ),
          const Spacer(),
          TextButton(
            onPressed: onSkip,
            child: Text('skip'.tr()),
          )
        ],
      ),
    );
  }
}
