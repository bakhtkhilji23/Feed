import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';

class ActiveIndicatorRect extends StatelessWidget {
  const ActiveIndicatorRect({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppDefaults.duration,
      width: isActive ? 20 : 10,
      height: 6,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary
            : AppColors.placeholder.withOpacity(0.6),
        borderRadius: AppDefaults.borderRadius,
      ),
    );
  }
}
