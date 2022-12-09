import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:news_pro/views/auth/components/select_profile_image_widget.dart';
import 'package:news_pro/views/auth/components/shoot_profile_image_widget.dart';
import 'package:news_pro/views/auth/components/show_my_bottom_sheet.dart';
import 'package:validators/validators.dart' as validator;

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/constants/sizedbox_const.dart';
import '../../core/controllers/auth/auth_controller.dart';
import 'components/already_have_account_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'Sign Up',
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontFamily: 'Avenir'),
        ),
      ),
      body: const SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SignupForm(),
          ),
        ),
      ),
      bottomNavigationBar: const AlreadyHaveAccountButton(),
    );
  }
}

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<SignupForm> {
  File? selectedImage;
  bool showImageErrorText = false;

  late TextEditingController _username;
  late TextEditingController _email;
  late TextEditingController _pass;
  late TextEditingController _surname;
  late TextEditingController _name;

  bool _isCreating = false;

  //Password Input
  bool _obscureText = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // bool _isAgreed = false;

  Future<void> _signUp() async {
    if (_isCreating) {
      // so that we won't trigger our function twice
      return;
    } else {
      bool isValid = _formKey.currentState?.validate() ?? false;
      bool isImageSelected = selectedImage != null;

      if (!isImageSelected) {
        setState(() {
          showImageErrorText = true;
        });
        return;
      }

      if (isValid && isImageSelected) {
        _isCreating = true;
        if (mounted) setState(() {});

        bool isValidUser = await ref.read(authController.notifier).signup(
          username: _username.text,
          email: _email.text,
          firstName: _name.text,
          lastName: _surname.text,
          profileUrl: selectedImage!,
          password: _pass.text,
          context: context,
        );
        if (isValidUser) {
        } else {
          _isCreating = false;
          if (mounted) setState(() {});
        }
      }
      //  else if (!_isAgreed) {
      //   Fluttertoast.showToast(msg: 'Terms & Services must be Agreed');
      // }
    }
  }

  /// Formkey
  final _formKey = GlobalKey<FormState>();
  // Initially password is obscure

  @override
  void initState() {
    super.initState();
    _username = TextEditingController();
    _email = TextEditingController();
    _pass = TextEditingController();
    _surname = TextEditingController();
    _name = TextEditingController();
  }

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _pass.dispose();
    _surname.dispose();
    _name.dispose();
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: MediaQuery.of(context).size.width * 0.40,
                    child: selectedImage != null
                        ? Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: WPConfig.primaryColor,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  MediaQuery.of(context).size.width *
                                      0.40,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  MediaQuery.of(context).size.width *
                                      0.40,
                                ),
                              ),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          bottom: 6,
                          end: 6,
                          child: InkWell(
                            enableFeedback: false,
                            onTap: () async {
                              setState(() {
                                selectedImage = null;
                              });
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: const BoxDecoration(
                                color: WPConfig.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                        : InkWell(
                      borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.40,
                      ),
                      onTap: () {
                        showMyBottomSheet(
                          context,
                          body: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 20),
                              const Text(
                                'Choose from',
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SelectProfileImageWidget(
                                      onSelect: (selectedImage) async {
                                        this.selectedImage =
                                            selectedImage;
                                        setState(() {
                                          showImageErrorText = false;
                                        });
                                      },
                                      onDelete: () {
                                        showImageErrorText = true;
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: ShootProfileImageWidget(
                                      onSelect: (selectedImage) {
                                        this.selectedImage =
                                            selectedImage;
                                        setState(() {
                                          showImageErrorText = false;
                                        });
                                      },
                                      onDelete: () {
                                        showImageErrorText = true;
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/others/select.png',
                      ),
                    ),
                  ),
                ),
                if (showImageErrorText)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 6),
                      Text(
                        'Image is required',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: 'Name'.tr(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v == '') {
                      return 'Name_required';
                    }
                    return null;
                  },
                ),
                AppSizedBox.h16,
                TextFormField(
                  controller: _surname,
                  decoration: InputDecoration(
                    labelText: 'Surname'.tr(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v == '') {
                      return 'Surname_required';
                    }
                    return null;
                  },
                ),
                AppSizedBox.h16,
                TextFormField(
                  controller: _username,
                  decoration: InputDecoration(
                    labelText: 'username'.tr(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    // prefixIcon: const Icon(IconlyLight.profile),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (v) {
                    if (v == null || v == '') {
                      return 'user_name_required';
                    }
                    return null;
                  },
                ),
                AppSizedBox.h16,
                TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    labelText: 'email'.tr(),
                    // prefixIcon: const Icon(IconlyLight.message),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || !validator.isEmail(v)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                AppSizedBox.h16,
                TextFormField(
                  controller: _pass,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'password'.tr(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: _toggle,
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  validator: (v) {
                    if (v == null || v == '') {
                      return 'password_required'.tr();
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //   child: Row(
        //     children: [
        //       Checkbox(
        //         value: _isAgreed,
        //         onChanged: (v) {
        //           _isAgreed = !_isAgreed;
        //           setState(() {});
        //         },
        //       ),
        //       Expanded(
        //         child: Row(
        //           children: [
        //             const Text('Agree to our '),
        //             TextButton(
        //               onPressed: () {
        //                 AppUtil.openLink(WPConfig.termsAndServicesUrl);
        //               },
        //               style: TextButton.styleFrom(
        //                 padding: EdgeInsets.zero,
        //               ),
        //               child: const Text('Terms & Services'),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(AppDefaults.margin),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _signUp,
              child: _isCreating
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text('sign_up'.tr()),
            ),
          ),
        ),
      ],
    );
  }
}