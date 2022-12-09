import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/constants/constants.dart';
import '../../../core/controllers/auth/auth_controller.dart';
import '../../../core/repositories/auth/auth_repository.dart';
import '../../../core/repositories/users/user_repository.dart';
import '../../../core/utils/responsive.dart';

class DeleteUserDialog extends ConsumerStatefulWidget {
  const DeleteUserDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<DeleteUserDialog> createState() => _DeleteUserDialogState();
}

class _DeleteUserDialogState extends ConsumerState<DeleteUserDialog> {
  late Timer _timer;
  int _commentTimeRemaining = 10;

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

  bool isDeleting = false;

  /// On Delete Users
  onDelete() async {
    if (_commentTimeRemaining == 0) {
      isDeleting = true;
      if (mounted) setState(() {});
      final token = await AuthRepository().getToken();
      final auth = ref.read(authController.notifier);
      if (token == null) return;
      await UserRepository.deleteUsers(token);
      // ignore: use_build_context_synchronously
      await auth.logout(context);
      isDeleting = false;
      if (mounted) setState(() {});
    } else {
      Fluttertoast.showToast(msg: 'Please read the info first');
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Theme.of(context).cardColor,
      child: SizedBox(
        width: Responsive.isMobile(context)
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * 0.3,
        child: Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'warning'.tr(),
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Divider(),
              AppSizedBox.h10,
              Text(
                'Delete your account?',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              AppSizedBox.h10,
              Text(
                'Are you sure you want to delete your account? This action cannot be undone',
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              ),
              AppSizedBox.h16,
              if (!isDeleting) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onDelete,
                    style: ElevatedButton.styleFrom(
                      primary:
                          _commentTimeRemaining == 0 ? Colors.red : Colors.grey,
                    ),
                    child: Text(_commentTimeRemaining == 0
                        ? 'delete'.tr()
                        : _commentTimeRemaining.toString()),
                  ),
                ),
                AppSizedBox.h16,
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(),
                    child: Text('cancel'.tr()),
                  ),
                ),
              ],
              if (isDeleting) const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
