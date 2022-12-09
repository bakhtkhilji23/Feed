import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

class OnboardingActiveDot extends StatelessWidget {
  const OnboardingActiveDot({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppDefaults.duration,
      margin: const EdgeInsets.all(AppDefaults.margin / 4),
      width: isActive ? 30 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.grey.shade300,
        borderRadius: AppDefaults.borderRadius,
      ),
    );
  }
}
