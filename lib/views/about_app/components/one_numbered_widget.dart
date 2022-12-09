import 'package:flutter/material.dart';

class OneNumberedWidget extends StatelessWidget {
  const OneNumberedWidget({
    Key? key,
    required this.number,
    required this.text,
    required this.text2,
  }) : super(key: key);

  final String number;
  final String text;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFf5e6ca),
            shape: BoxShape.circle,
            boxShadow: kElevationToShadow[1],
          ),
          child: Text(number),
        ),
        const SizedBox(width: 16),
        RichText(
          text: TextSpan(
              text: text,
              style: Theme.of(context).primaryTextTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
              children: [
                TextSpan(
                  text: text2,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 14, color: Colors.black),
                )
              ]),
        ),
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       text,
        //       // todo changed
        //       // style: paragrahTextStyle.copyWith(
        //       style: Theme.of(context).primaryTextTheme.bodyMedium?.copyWith(
        //           fontSize: 14,
        //           fontWeight: FontWeight.w800,
        //           color: Colors.black),
        //     ),
        //     Text(
        //       text2,
        //       // todo changed
        //       // style: paragrahTextStyle.copyWith(
        //       style: Theme.of(context).primaryTextTheme.bodyMedium?.copyWith(
        //           fontSize: 14,
        //           fontWeight: FontWeight.w400,
        //           color: Colors.black),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
