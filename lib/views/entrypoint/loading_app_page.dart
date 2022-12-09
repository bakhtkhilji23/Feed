import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_pro/views/auth/login_page.dart';

import '../../config/wp_config.dart';
import '../../core/app/core_provider.dart';
import '../../core/controllers/auth/auth_controller.dart';
import '../auth/login_intro_page.dart';
import '../onboarding/onboarding_page.dart';
import 'components/loading_dependency.dart';
import 'entrypoint.dart';

class LoadingAppPage extends ConsumerWidget {
  const LoadingAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(coreAppStateProvider(context));
    return appState.map(
        data: (initialState) {
          switch (initialState.value) {
            case AppState.introNotDone:
              return const OnboardingPage();
            case AppState.loggedIn:
              return const EntryPointUI();
            case AppState.loggedOut:
              return WPConfig.forceUserToLoginEverytime
                  ? const LoginPage()
                  : const EntryPointUI();
            default:
              return const EntryPointUI();
          }

          // return const LoginPage();
        },
        error: (t) => const Text('Unknown Error'),
        loading: (t) => const LoadingDependencies());
  }
}