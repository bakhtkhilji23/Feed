import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import '../constants/app_colors.dart';

class AppUtil {
  static String totalMinute(String theString, BuildContext context) {
    int wpm = 225;
    int totalWords = theString.trim().split(' ').length;
    int totalMinutes = (totalWords / wpm).ceil();
    final totalMinutesFormat =
        NumberFormat('', context.locale.toLanguageTag()).format(totalMinutes);
    return totalMinutesFormat;
  }

  /// Dismissises Keyboard From Anywhere
  static void dismissKeyboard({required BuildContext context}) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  /// Set The Portrait as Default Orientation
  static Future<void> autoRotateOff() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  /// Set status bar and Color to Light
  static Future<void> setStatusBarDark() async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );
  }

  /// Set status bar and Color to Dark
  static Future<void> setStatusBarLight() async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
    );
  }

  static Future<void> applyStatusBarColor(bool isDark) async {
    if (isDark) {
      setStatusBarDark();
    } else {
      setStatusBarLight();
    }
  }

  /// Set the display refresh rate to maximum
  /// Doesn't apply to IOS
  static void setDisplayToHighRefreshRate() {
    if (Platform.isAndroid) {
      try {
        FlutterDisplayMode.setHighRefreshRate();
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      debugPrint('High Refresh Rate is not supported in ios');
    }
  }

  /// Launch url
  static Future<void> launchUrl(String url) async {
    bool canLaunch = await launcher.canLaunchUrl(Uri.parse(url));
    if (canLaunch) {
      launcher.launchUrl(Uri.parse(url));
    } else {
      Fluttertoast.showToast(msg: 'Oops, can\'t launch this url');
    }
  }

  /// Open links inside app
  static Future<void> openLink(String url) async {
    try {
      final validUrl = Uri.parse(url);
      await FlutterWebBrowser.openWebPage(
        url: validUrl.toString(),
        customTabsOptions: const CustomTabsOptions(
          colorScheme: CustomTabsColorScheme.dark,
          shareState: CustomTabsShareState.on,
          instantAppsEnabled: true,
          showTitle: true,
          urlBarHidingEnabled: true,
        ),
        safariVCOptions: const SafariViewControllerOptions(
          barCollapsingEnabled: true,
          preferredBarTintColor: AppColors.scaffoldBackground,
          preferredControlTintColor: AppColors.primary,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
          modalPresentationCapturesStatusBarAppearance: true,
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'Invalid URL');
    }
  }
}
