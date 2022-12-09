import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';

class AppVideo extends StatefulWidget {
  const AppVideo({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<AppVideo> createState() => _AppVideoState();
}

class _AppVideoState extends State<AppVideo> {
  late BetterPlayerController _controller;

  @override
  void initState() {
    super.initState();
    final dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.url,
      cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
    );
    _controller = BetterPlayerController(
      BetterPlayerConfiguration(
        // aspectRatio: AppDefaults.aspectRatio,
        deviceOrientationsAfterFullScreen: const [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableOverflowMenu: false,
          enableSkips: false,
          enableFullscreen: true,
          fullscreenEnableIcon: Icons.fullscreen_rounded,
          progressBarHandleColor: AppColors.primary,
          progressBarPlayedColor: AppColors.primary.withOpacity(0.5),
          progressBarBackgroundColor: Colors.grey,
        ),
      ),
      betterPlayerDataSource: dataSource,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(
      controller: _controller,
    );
  }
}
