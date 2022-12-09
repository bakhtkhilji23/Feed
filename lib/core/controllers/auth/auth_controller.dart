import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/member.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../routes/app_routes.dart';
import 'auth_state.dart';

final authController = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return AuthNotifier(authRepo);
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this.repository) : super(AuthGuestLoggedIn()) {
    _init();
  }

  final AuthRepository repository;

  _init() async {
    Member? theUser = await repository.getUser();
    if (theUser != null) {
      debugPrint('Got a user');
      debugPrint('The useremail is ${theUser.email}');
      final token = await repository.getToken();
      if (token != null) {
        debugPrint('Got a token');
        bool isValid = await repository.vallidateToken(token: token);
        if (isValid) {
          debugPrint('Token is valid');
          state = AuthLoggedIn(theUser);
          debugPrint('Settted State to Logged IN');
        } else {
          // Token is not valid
          debugPrint('Token is not valid');
        }
      } else {
        // No token has been saved
        debugPrint('No token has been saved');
      }
    } else {
      // No user has been saved
      debugPrint('No User has been saved');
    }
  }

  /// Login User
  Future<String?> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final member = await repository.login(email: email, password: password);
    if (member != null) {
      state = AuthLoggedIn(member);
      if (mounted) Navigator.pushNamed(context, AppRoutes.loginAnimation);
      return null;
    } else {
      return 'Invalid Credintials';
    }
  }

  /// Login User
  Future<bool> signup({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required File profileUrl,
    required BuildContext context,
  }) async {
    final isCreated = await repository.signUp(
      userName: username,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      profileUrl: profileUrl,
    );
    if (isCreated == true) {
      /// Login With the new details
      await login(email: email, password: password, context: context);
      return true;
    } else {
      Fluttertoast.showToast(msg: 'Invalid Credintials');
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    state = AuthState();
    await repository.logout();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (v) => false);
    }
  }

  Future<String?> sendResetLinkToEmail(String email) async {
    bool isValid = await repository.sendPasswordResetLink(email);
    if (isValid) {
      return null;
    } else {
      return 'The email is not registered';
    }
  }

  Future<bool> validateOTP({required int otp, required String email}) async {
    return await repository.verifyOTP(otp: otp, email: email);
  }

  Future<bool> resetPassword({
    required String newPassword,
    required String email,
    required int otp,
  }) async {
    bool changed = await repository.setPassword(
      email: email,
      newPassword: newPassword,
      otp: otp,
    );
    return changed;
  }
}
