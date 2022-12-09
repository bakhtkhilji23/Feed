import 'package:flutter/material.dart';

import '../constants/constants.dart';

class BottomSheetTopHandler extends StatelessWidget {
  const BottomSheetTopHandler({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.margin / 2),
      width: MediaQuery.of(context).size.width * 0.3,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.placeholder.withOpacity(0.3),
      ),
    );
  }
}
