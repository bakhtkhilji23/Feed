import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/routes/app_routes.dart';

class LoggingInAnimation extends StatefulWidget {
  const LoggingInAnimation({Key? key}) : super(key: key);

  @override
  State<LoggingInAnimation> createState() => _LoggingInAnimationState();
}

class _LoggingInAnimationState extends State<LoggingInAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: Lottie.asset(
            'assets/animations/animation_done.json',
            controller: _controller,
            frameRate: FrameRate.max,
            onLoaded: (composition) {
              // Configure the AnimationController with the duration of the
              // Lottie file and start the animation.
              _controller
                ..duration = composition.duration
                ..forward().whenComplete(() => {
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.entryPoint, (v) => false)
                    });
            },
          ),
        ),
      ),
    );
  }
}
