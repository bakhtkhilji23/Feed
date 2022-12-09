import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart' as u;

import '../../models/notification_model.dart';

class NotificationsRepository {
  final String _boxName = 'notifications_box';

  /// Initialize Local Notifcations
  Future<NotificationsRepository> init() async {
    await Hive.openLazyBox(_notificationSwitchBox);
    await Hive.openLazyBox(_boxName);
    return NotificationsRepository();
  }

  /// Save a notification to database
  Future<void> saveNotification(NotificationModel data) async {
    await _InstanceNotification().insert(data);
  }

  /// Delete A Notification
  Future<void> deleteANotification(NotificationModel target) async {
    await _InstanceNotification().delete(target);
  }

  /// Delete A Notification
  Future<void> clearAllNotifications() async {
    await _InstanceNotification().deleteAll();
  }

  /// Get All Notifications
  Future<List<NotificationModel>> getAllNotifications() async {
    return await _InstanceNotification().getAll();
  }

  /* <---- Notifications Settings -----> */
  final String _notificationSwitchBox = 'notificationSwitchBox';
  final String _toggle = 'notificationToggle';

  Future<bool> isNotificationOn() async {
    var box = await Hive.openLazyBox(_notificationSwitchBox);
    return await box.get(_toggle) ?? true;
  }

  /// Turn on notifications
  Future<void> turnOnNotifications() async {
    var box = await Hive.openLazyBox(_notificationSwitchBox);
    await box.put(_toggle, true);
  }

  /// Turn off notifications
  Future<void> turnOffNotifications() async {
    var box = await Hive.openLazyBox(_notificationSwitchBox);
    box.put(_toggle, false);
  }
}

class _InstanceNotification {
  final _uuid = const u.Uuid();

  Future<bool> insert(NotificationModel notificationModel) async {
    try {
      final jsonFile = await _getFileObjectNotification();
      if (jsonFile == null) return false;
      notificationModel.id = _uuid.v1();

      List<dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.add(notificationModel);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));

      return true;
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  Future<bool> update(NotificationModel notificationModel) async {
    try {
      final listFiles = await getAll();
      final jsonFile = await _getFileObjectNotification();
      if (jsonFile == null) return false;
      final singleSearch =
          listFiles.firstWhere((element) => element.id == notificationModel.id);
      final indexUpdate = listFiles.indexOf(singleSearch);

      listFiles[indexUpdate] = notificationModel;

      jsonFile.writeAsStringSync(json.encode(listFiles));

      return true;
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  Future<bool> delete(NotificationModel notificationModel) async {
    try {
      final listFiles = await getAll();
      final jsonFile = await _getFileObjectNotification();
      if (jsonFile == null) return false;
      if (listFiles.isNotEmpty) {
        if (listFiles.length == 1) {
          jsonFile.writeAsStringSync(json.encode([]));
        } else {
          listFiles
              .removeWhere((element) => element.id == notificationModel.id);
          jsonFile.writeAsStringSync(json.encode(listFiles));
        }
      }

      return true;
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  Future<bool> deleteAll() async {
    try {
      final jsonFile = await _getFileObjectNotification();
      if (jsonFile == null) return false;
      jsonFile.writeAsStringSync(json.encode([]));

      return true;
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  Future<List<NotificationModel>> getAll() async {
    try {
      final jsonFile = await _getFileObjectNotification();
      if (jsonFile == null) return [];
      List<dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());

      List<NotificationModel> notifications = [];
      if (jsonFileContent.isNotEmpty) {
        for (var element in jsonFileContent) {
          notifications.add(NotificationModel.fromJson(element));
        }
      }

      return notifications;
    } catch (e) {
      debugPrint(e.toString());
    }

    return [];
  }

  static Future<File?> _getFileObjectNotification() async {
    try {
      final databasePathRoot = await getApplicationDocumentsDirectory();
      final dataBasePath = databasePathRoot.path;
      const fileName = 'notification.json';
      final databasePath = p.join(dataBasePath, fileName);

      File file = File(databasePath);

      if (!await File(databasePath).exists()) {
        file.createSync();
        file.writeAsStringSync(json.encode([]));
      }

      return file;
    } catch (e) {
      debugPrint(e.toString());
    }

    return null;
  }
}
