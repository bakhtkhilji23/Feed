import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({
    Key? key,
    required this.name,
    required this.isActive,
  }) : super(key: key);

  final String name;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? AppColors.primary : Colors.grey.shade500,
                  fontSize: 14,
                ),
          ),
          AppSizedBox.h5,
          AnimatedContainer(
            duration: AppDefaults.duration,
            height: 3,
            color: isActive ? AppColors.primary : Colors.transparent,
          )
        ],
      ),
    );
  }
}
