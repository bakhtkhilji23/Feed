import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:news_pro/config/wp_config.dart';

import '../../../core/constants/constants.dart';
import '../../../core/controllers/notifications/notification_local.dart';
import '../../../core/models/notification_model.dart';
import '../../../core/utils/ui_util.dart';
import 'components/notification_tile.dart';
import 'components/notifications_empty.dart';
import 'dialogs/clear_notification.dart';

class NotificationPage extends ConsumerWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(localNotificationProvider);
    final controller = ref.read(localNotificationProvider.notifier);
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: WPConfig.primaryColor,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'notification'.tr(),
                style: const TextStyle(color: Colors.white),
              ),
              AppSizedBox.w10,
              const Icon(
                IconlyLight.notification,
                size: 18,
                color: Colors.white,
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                UiUtil.openDialog(
                    context: context, widget: const ClearNotificationDialog());
              },
              icon: const Icon(
                IconlyLight.closeSquare,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: SafeArea(
          child: notifications.map(
            data: ((data) => data.value.isEmpty
                ? const NotificationIsEmpty()
                : NotificationsList(
              data: data.value,
              controller: controller,
            )),
            error: (t) => Center(child: Text(t.toString())),
            loading: (v) => const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

class NotificationsList extends StatelessWidget {
  const NotificationsList({
    Key? key,
    required this.data,
    required LocalNotificationNotifier controller,
  })  : _controller = controller,
        super(key: key);

  final LocalNotificationNotifier _controller;
  final List<NotificationModel> data;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return NotificationDetailsWidget(
              data: data[index],
              onDelete: () {
                _controller.deleteNotification(data[index]);
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}