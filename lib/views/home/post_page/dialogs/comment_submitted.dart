import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class CommentSubmittedSuccessfully extends StatelessWidget {
  const CommentSubmittedSuccessfully({
    Key? key,
    this.isReply = false,
  }) : super(key: key);

  final bool isReply;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: AppDefaults.borderRadius),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isReply ? 'reply_submitted'.tr() : 'comment_submitted'.tr(),
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            AppSizedBox.h16,
            Text(
              isReply
                  ? 'reply_submitted_message'.tr()
                  : 'comment_submitted_message'.tr(),
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
            AppSizedBox.h16,
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
