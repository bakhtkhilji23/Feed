import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/components/headline_with_row.dart';
import '../../core/constants/constants.dart';
import '../../core/controllers/auth/auth_controller.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ResetPasswordForm(email: email),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: TextButton(
          onPressed: () {
            // Navigator.pop(context);
            SystemNavigator.pop(animated: true);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.adaptive.arrow_back_rounded, size: 16),
              AppSizedBox.w5,
              Text('go_back'.tr()),
            ],
          ),
        ),
      ),
    );
  }
}

class ResetPasswordForm extends ConsumerStatefulWidget {
  const ResetPasswordForm({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  ConsumerState<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends ConsumerState<ResetPasswordForm> {
  String email = '';
  String? errorMessage;

  late TextEditingController _otp;
  late TextEditingController _firstPass;
  late TextEditingController _secondPass;
  bool _isPasswordResetting = false;

  Future<void> _resetPassword() async {
    final authProvider = ref.read(authController.notifier);

    bool isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      _isPasswordResetting = true;
      setState(() {});

      bool isOTPValid = await authProvider.validateOTP(
          otp: int.parse(_otp.text), email: email);
      if (isOTPValid) {
        bool passwordReseted = await authProvider.resetPassword(
          newPassword: _firstPass.text,
          email: email,
          otp: int.parse(_otp.text),
        );

        if (passwordReseted) {
          await authProvider.login(
            email: email,
            password: _firstPass.text,
            context: context,
          );
        } else {
          Fluttertoast.showToast(msg: 'Having problems while logging in');
        }
        _isPasswordResetting = false;
        setState(() {});
      } else {
        errorMessage = 'Invalid OTP, Please enter a valid one';
        _isPasswordResetting = false;
        setState(() {});
      }
    }
  }

  /// Formkey
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    email = widget.email;
    _otp = TextEditingController();
    _firstPass = TextEditingController();
    _secondPass = TextEditingController();
  }

  @override
  void dispose() {
    _otp.dispose();
    _firstPass.dispose();
    _secondPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const HeadlineRow(
                  headline: 'reset_pass',
                  fontColor: AppColors.primary,
                ),
                AppSizedBox.h16,
                Text(
                  'reset_pass_message'.tr(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                AppSizedBox.h16,
                AppSizedBox.h16,
                TextFormField(
                  controller: _otp,
                  decoration: InputDecoration(
                    labelText: 'OTP',
                    prefixIcon: const Icon(IconlyLight.lock),
                    errorText: errorMessage,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v == '') {
                      return 'OTP is not valid';
                    }
                    return null;
                  },
                ),
                AppSizedBox.h16,
                TextFormField(
                  controller: _firstPass,
                  decoration: InputDecoration(
                    labelText: 'password'.tr(),
                    prefixIcon: const Icon(IconlyLight.password),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'password_required'.tr();
                    } else if (_firstPass.text != _secondPass.text) {
                      return 'password_not_matching'.tr();
                    }
                    return null;
                  },
                ),
                AppSizedBox.h16,
                TextFormField(
                  controller: _secondPass,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'confirm_password'.tr(),
                    prefixIcon: const Icon(IconlyLight.password),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'password_required'.tr();
                    } else if (_secondPass.text != _firstPass.text) {
                      return 'password_not_matching'.tr();
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppDefaults.margin),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _resetPassword,
              child: _isPasswordResetting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text('reset_pass'.tr()),
            ),
          ),
        ),
      ],
    );
  }
}
