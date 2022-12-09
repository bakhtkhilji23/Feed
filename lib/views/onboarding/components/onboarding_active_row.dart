import 'package:flutter/material.dart';

import 'onboarding_active_dot.dart';

class OnboardingActiveRow extends StatelessWidget {
  const OnboardingActiveRow({
    Key? key,
    required this.totalLength,
    required this.currentIndex,
  }) : super(key: key);

  final int totalLength;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalLength,
        (index) => OnboardingActiveDot(isActive: index == currentIndex),
      ),
    );
  }
}
