import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../config/ad_config.dart';

class AdIdProvider {
  /// Get the Banner id of respected platforms
  static String get bannerID {
    if (kDebugMode) {
      return _getDebugBannerAd();
    } else if (Platform.isAndroid) {
      return AdConfig.androidBannerAdID;
    } else if (Platform.isIOS) {
      return AdConfig.iosBannerAdID;
    } else {
      throw UnimplementedError(
          'Ad ID is not supported in ${Platform.operatingSystem}');
    }
  }

  /// Get the interstitial id of the respected platforms
  static String get interstitial {
    if (kDebugMode) {
      debugPrint('Using Debug Mode Interstitial id');
      return _getDebugIntersetialAd();
    } else if (Platform.isAndroid) {
      return AdConfig.androidInterstitialAdID;
    } else if (Platform.isIOS) {
      return AdConfig.iosInterstitialAdID;
    } else {
      throw UnimplementedError(
          'Ad ID is not supported in ${Platform.operatingSystem}');
    }
  }

  /// TEST AD ID's For testing, Don't use it in real world app
  /// android
  static const _testAndroidBanner = 'ca-app-pub-3940256099942544/6300978111';
  static const _testAndroidIntersetial =
      'ca-app-pub-3940256099942544/10331737121';

  // ios
  static const _testIosBanner = 'ca-app-pub-3940256099942544/2934735716';
  static const _testIosIntersetial = 'ca-app-pub-3940256099942544/4411468910';

  static _getDebugBannerAd() {
    if (Platform.isAndroid) {
      return _testAndroidBanner;
    } else if (Platform.isIOS) {
      return _testIosBanner;
    } else {
      throw UnimplementedError(
          'Ad ID is not supported in ${Platform.operatingSystem}');
    }
  }

  static _getDebugIntersetialAd() {
    if (Platform.isAndroid) {
      return _testAndroidIntersetial;
    } else if (Platform.isIOS) {
      return _testIosIntersetial;
    } else {
      throw UnimplementedError(
          'Ad ID is not supported in ${Platform.operatingSystem}');
    }
  }
}
