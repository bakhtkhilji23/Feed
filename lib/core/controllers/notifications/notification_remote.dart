import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../config/wp_config.dart';
import '../../../views/home/notification_page/dialogs/post_notification.dart';
import '../../models/notification_model.dart';
import '../../repositories/others/notification_local.dart';
import '../../repositories/posts/post_local_repository.dart';
import '../../repositories/posts/post_repository.dart';
import '../../routes/app_routes.dart';
import '../../utils/ui_util.dart';

final isNotificationOnProvider = StateProvider<bool>((ref) {
  return false;
});

/// To handle upcoming notification
/// [BuildContext] is needed for navigating to specific post page
final remoteNotificationProvider = StateNotifierProvider.family<
    NotificationNotifierRemote, dynamic, BuildContext>((ref, ctx) {
  final postRepo = ref.read(postRepoProvider);
  return NotificationNotifierRemote(ref, ctx, postRepo);
});

/// To handle upcoming notification
class NotificationNotifierRemote extends StateNotifier<AuthorizationStatus> {
  NotificationNotifierRemote(this.ref, this.context, this.postRepository)
      : super(AuthorizationStatus.notDetermined) {
    {
      _initializeService();
    }
  }

  final BuildContext context;
  final PostRepository postRepository;
  final _repository = NotificationsRepository();
  final StateNotifierProviderRef<NotificationNotifierRemote, dynamic> ref;

  /// Initialize Notificaiton Service based on user settings
  _initializeService() async {
    bool isNotificaitonOn = await _repository.isNotificationOn();

    ref
        .read(isNotificationOnProvider.state)
        .update((state) => isNotificaitonOn);
    if (isNotificaitonOn) {
      _subscribeToTopic();
      if (mounted) _setForegroundMessageListener(context);
    } else {
      _unSubscribeToTopic();
    }
  }

  /// Set the listener on app start
  _setForegroundMessageListener(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final notification =
          NotificationModel.fromMessage(message, DateTime.now());
      _repository.saveNotification(notification);

      /// Show a Dialog of post in notifications
      if (notification.postID != null &&
          WPConfig.showPostDialogOnNotificaiton) {
        final post = await postRepository.getPost(postID: notification.postID!);
        if (post != null) {
          UiUtil.openDialog(
              context: context, widget: PostOnNotification(post: post));
        } else {
          debugPrint('No Post Found with this id');
        }
      } else if (notification.postID != null &&
          WPConfig.showPostDialogOnNotificaiton == false) {
        Fluttertoast.showToast(msg: 'New Post:\n${notification.title}');
      } else {}
    });
  }

  /// Subscribe to topic 'all' on appstart
  _subscribeToTopic() async {
    await FirebaseMessaging.instance.subscribeToTopic('all');
  }

  _unSubscribeToTopic() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic('all');
  }

  handlePermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    state = settings.authorizationStatus;
    if (state == AuthorizationStatus.authorized) {
      /// User Granted Permission
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      /// User Granted Provisional permisser
    } else {
      /// User Declined or Has not decided
    }
  }

  /// Toggle Notification
  toggleNotification(bool isOn) async {
    if (isOn) {
      await _turnOffNotifications();
    } else {
      await _turnOnNotifications();
    }
    await _initializeService();
  }

  /// Turn on Notifications
  _turnOnNotifications() async {
    ref.read(isNotificationOnProvider.state).update((state) => true);
    await _repository.turnOnNotifications();
    Fluttertoast.showToast(msg: 'notification_on_message'.tr());
  }

  /// Turn off Notifications
  _turnOffNotifications() async {
    ref.read(isNotificationOnProvider.state).update((state) => false);
    await _repository.turnOffNotifications();
    Fluttertoast.showToast(msg: 'notification_off_message'.tr());
  }
}

/* <-----------------------> 
    HANDLES BACKGROUND NOTIFICAITONS    
 <-----------------------> */

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final repository = NotificationsRepository();
  final notification = NotificationModel.fromMessage(message, DateTime.now());
  repository.saveNotification(notification);
}

// It is assumed that all messages contain a data field with the key 'type'
Future<void> setupInteractedMessage(BuildContext context) async {
  // Get any messages which caused the application to open from
  // a terminated state.
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  // If the message also contains a data property with a "type" of "chat",
  // navigate to a chat screen
  if (initialMessage != null) {
    // ignore: use_build_context_synchronously
    _handleMessage(initialMessage, context);
  }

  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    _handleMessage(message, context);
  });
}

void _handleMessage(RemoteMessage message, BuildContext context) async {
  final postRepo = PostRepository(PostLocalRepository());

  final notification = NotificationModel.fromMessage(message, DateTime.now());

  final post = await postRepo.getPost(postID: notification.postID!);
  if (post != null) {
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, AppRoutes.post, arguments: post);
  } else {
    debugPrint('No Post Found with this id');
  }
}
