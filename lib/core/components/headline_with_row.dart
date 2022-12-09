import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class HeadlineRow extends StatelessWidget {
  const HeadlineRow({
    Key? key,
    required this.headline,
    this.width,
    this.fontColor,
    this.isHeader = true,
  }) : super(key: key);

  final String headline;
  final double? width;
  final Color? fontColor;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headline.tr(),
          style: isHeader
              ? Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: fontColor ?? Colors.white,
                  fontFamily: 'Avenir',
                  fontSize: 17)
              : Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: fontColor ?? Colors.white,
                  fontFamily: 'Avenir',
                  fontSize: 17),
        ),
        AppSizedBox.h5,
        Container(
          width: width ?? MediaQuery.of(context).size.width * 0.1,
          height: 2,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: AppDefaults.borderRadius,
          ),
        )
      ],
    );
  }
}
