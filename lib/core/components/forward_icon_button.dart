import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../constants/app_defaults.dart';

class ForwardIconButton extends StatelessWidget {
  const ForwardIconButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(AppDefaults.padding),
        ),
        child: const Icon(
          IconlyLight.arrowRight2,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
