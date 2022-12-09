import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<void> showMyBottomSheet(
  BuildContext context, {
  required Widget body,
}) async {
  await showMaterialModalBottomSheet(
    context: context,
    expand: false,
    useRootNavigator: false,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black26,
    builder: (context) {
      return SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: kElevationToShadow[6],
          ),
          child: body,
        ),
      );
    },
  );
}
