import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/constants/constants.dart';

class LoadingDependencies extends StatelessWidget {
  const LoadingDependencies({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff006199),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 7),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/others/splashlogo1.png',
                // color: Colors.transparent,
                height: 300,
                width: 400,
              ),

              // Image.asset(AppImages.appLogo),
            ),
            const Spacer(flex: 5),
            // LoadingAnimationWidget.dotsTriangle(
            //   color: AppColors.primary,
            //   size: 50,
            // ),
            // const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
