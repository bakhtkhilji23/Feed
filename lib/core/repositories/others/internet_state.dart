import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../components/internet_not_available.dart';
import '../../utils/ui_util.dart';

final internetStateProvider =
    StateNotifierProvider.family<InternetStateNotifier, bool, BuildContext>(
        (ref, ctx) {
  return InternetStateNotifier(ctx);
});

class InternetStateNotifier extends StateNotifier<bool> {
  final BuildContext context;
  InternetStateNotifier(this.context) : super(true) {
    {
      checkInternet(context);
    }
  }

  /// Check internet connection
  Future<bool> isInternetAvailable() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  checkInternet(BuildContext context) async {
    state = await isInternetAvailable();
    if (state) {
      /// Internet is available don't need to show anything
    } else {
      UiUtil.openDialog(
        context: context,
        widget: const InternetNotAvailableDialog(),
        isDismissable: false,
      );
    }
  }
}
