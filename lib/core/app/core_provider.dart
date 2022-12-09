import 'dart:async';
import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../config/ad_config.dart';
import '../controllers/auth/auth_controller.dart';
import '../controllers/notifications/notification_local.dart';
import '../controllers/notifications/notification_remote.dart';
import '../models/member.dart';
import '../repositories/auth/auth_repository.dart';
import '../repositories/others/notification_local.dart';
import '../repositories/others/onboarding_local.dart';
import '../repositories/others/search_local.dart';
import '../repositories/posts/post_local_repository.dart';
import '../themes/theme_manager.dart';
import '../utils/app_utils.dart';

/// App Initial State
enum AppState { introNotDone, loggedIn, loggedOut }

final coreAppStateProvider =
    FutureProvider.family<AppState, BuildContext>((ref, context) async {
  /// Load All Repository and Other Necassary Services Here

  Directory appDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path);

  final onboarding = await OnboardingRepository().init();
  ref.read(authRepositoryProvider).init();
  ref.read(postLocalRepoProvider).init();
  await SearchLocalRepo().init();
  await Firebase.initializeApp();
  await NotificationsRepository().init();
  if (AdConfig.isAdOn) await MobileAds.instance.initialize();

  ref.read(authController);
  ref.read(localNotificationProvider);

  /// Handles background notification
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // ignore: use_build_context_synchronously
  setupInteractedMessage(context);

  /// Set Status Bar Color
  final theThemeMode =
      await ref.read(themeModeProvider.notifier).getThemeMode();
  await AppUtil.applyStatusBarColor(theThemeMode == AdaptiveThemeMode.dark);

  Member? responce = await ref.read(authRepositoryProvider).getUser();
  // Is user has been introduced to our app
  if (onboarding.isIntroDone()) {
    /// here check local database.
    if(responce == null){
      return AppState.loggedOut;
    }else{
      return AppState.loggedIn;
    }
  } else {
    return AppState.introNotDone;
  }
});
