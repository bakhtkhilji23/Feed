import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/controllers/auth/auth_controller.dart';
import '../../../../core/controllers/comments/comments_controllers.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/utils/ui_util.dart';
import '../dialogs/comment_submitted.dart';

class ReplyTextField extends ConsumerStatefulWidget {
  const ReplyTextField({
    Key? key,
    required this.postId,
    required this.parentCommentID,
    required this.userName,
    required this.onCancel,
  }) : super(key: key);
  final int postId;
  final int parentCommentID;
  final String userName;
  final void Function() onCancel;

  @override
  ConsumerState<ReplyTextField> createState() => _ReplyTextFieldState();
}

class _ReplyTextFieldState extends ConsumerState<ReplyTextField> {
  /// Text Controllers
  late TextEditingController _comment;

  /// Is Adding Comment
  bool isAddingComment = false;

  /// Submit Comment
  Future<void> submitReply() async {
    final user = ref.read(authController).member;
    final commentsNotifier =
        ref.read(postCommentController(widget.postId).notifier);
    bool isValid = _key.currentState?.validate() ?? false;
    if (isValid) {
      AppUtil.dismissKeyboard(context: context);
      isAddingComment = true;
      if (mounted) {
        setState(() {});
      }
      await commentsNotifier.writeReply(
        email: user!.email,
        name: user.name,
        content: _comment.text,
        parentCommentID: widget.parentCommentID,
      );
      _comment.clear();
      widget.onCancel();
      // UiUtil.openDialog(
      //     context: context,
      //     widget: const CommentSubmittedSuccessfully(
      //       isReply: true,
      //     ));
      _commentTimeRemaining = 10;
      startTimer();

      isAddingComment = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  /// Formkey
  final _key = GlobalKey<FormState>();

  late Timer _timer;
  int _commentTimeRemaining = 4;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_commentTimeRemaining == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _commentTimeRemaining--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _comment = TextEditingController();
    startTimer();
  }

  @override
  void dispose() {
    _comment.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// TO AVOID SPAMMERS WE HAVE IMPLEMENTED THIS
    if (_commentTimeRemaining > 0) {
      return Column(
        children: [
          AppSizedBox.h16,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.threeRotatingDots(
                  color: AppColors.primary, size: 30),
              AppSizedBox.w16,
              Expanded(
                child: Text(
                  'comment_wait_message'.tr(),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
              AppSizedBox.w16,
              Text(
                _commentTimeRemaining.toString(),
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.reply, color: AppColors.primary),
                AppSizedBox.w10,
                Text('replying_to'.tr()),
                Text(
                  widget.userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: widget.onCancel,
                  icon: const Icon(Icons.close),
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Form(
                  key: _key,
                  child: TextFormField(
                    controller: _comment,
                    onFieldSubmitted: (v) {},
                    validator: (v) {
                      if (v == null || v == '') {
                        return 'comment_error_message'.tr();
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(labelText: 'write_reply'.tr()),
                  ),
                ),
              ),
              AppSizedBox.w10,
              isAddingComment
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: submitReply,
                      child: const Icon(IconlyLight.send),
                    )
            ],
          ),
        ],
      );
    }
  }
}
