import 'package:flutter/cupertino.dart';
import 'package:news_pro/core/controllers/posts/poem_page.dart';
import 'package:news_pro/views/about_app/about_news_page.dart';
import 'package:news_pro/views/about_sg/profile_page.dart';
import 'package:news_pro/views/contact/contact_page.dart';
import 'package:news_pro/views/saved/saved_page.dart';
import 'package:news_pro/views/settings/settings_page.dart';
import 'package:news_pro/views/ten_minutes_transformation/ten_minutes_transformation_page.dart';

import '../../views/auth/forgot_password_page.dart';
import '../../views/auth/login_animation.dart';
import '../../views/auth/login_intro_page.dart';
import '../../views/auth/login_page.dart';
import '../../views/auth/reset_password_page.dart';
import '../../views/auth/signup_page.dart';
import '../../views/entrypoint/entrypoint.dart';
import '../../views/entrypoint/loading_app_page.dart';
import '../../views/explore/category_page.dart';
import '../../views/explore/search_page.dart';
import '../../views/explore/tag_posts_page.dart';
import '../../views/home/home_page/components/popular_videos.dart';
import '../../views/home/notification_page/notification_page.dart';
import '../../views/home/post_page/load_comments.dart';
import '../../views/home/post_page/post_page.dart';
import '../../views/onboarding/select_language_theme_page.dart';
import '../models/article.dart';
import '../models/post_tag.dart';
import 'app_routes.dart';
import 'unknown_page.dart';

class RouteGenerator {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;
    final args = settings.arguments;

    switch (route) {
      case AppRoutes.initial:
        return CupertinoPageRoute(builder: (_) => const LoadingAppPage());

      case AppRoutes.loadingApp:
        return CupertinoPageRoute(builder: (_) => const LoadingAppPage());

      case AppRoutes.selectThemeAndLang:
        return CupertinoPageRoute(
            builder: (_) => const SelectLanguageAndThemePage());

      case AppRoutes.entryPoint:
        return CupertinoPageRoute(builder: (_) => const EntryPointUI());

      case AppRoutes.login:
        return CupertinoPageRoute(builder: (_) => const LoginPage());

      case AppRoutes.loginAnimation:
        return CupertinoPageRoute(builder: (_) => const LoggingInAnimation());

      case AppRoutes.loginIntro:
        return CupertinoPageRoute(builder: (_) => const LoginIntroPage());

      case AppRoutes.signup:
        return CupertinoPageRoute(builder: (_) => const SignUpPage());

      case AppRoutes.forgotPass:
        return CupertinoPageRoute(builder: (_) => const ForgotPasswordPage());

      case AppRoutes.resetPass:
        if (args is String) {
          return CupertinoPageRoute(
              builder: (_) => ResetPasswordPage(email: args));
        } else {
          return errorRoute();
        }

      case AppRoutes.search:
        return CupertinoPageRoute(builder: (_) => const SearchPage());

      case AppRoutes.youtube:
        return CupertinoPageRoute(builder: (_) => PopularVideosPage());

      case AppRoutes.settings:
        return CupertinoPageRoute(builder: (_) => const SettingsPage());

      case AppRoutes.notification:
        return CupertinoPageRoute(builder: (_) => const NotificationPage());

      case AppRoutes.post:
        final args2 = args as List;
        if (args2[0] is ArticleModel) {
          return CupertinoPageRoute(
              builder: (_) =>
                  PostPage(article: args2[0], isSpecialSession: args2[1]));
        } else {
          return errorRoute();
        }

      case AppRoutes.poem:
        if (args is ArticleModel) {
          return CupertinoPageRoute(builder: (_) => PoemPage(article: args));
        } else {
          return errorRoute();
        }
      case AppRoutes.about:
        return CupertinoPageRoute(builder: (_) => AboutNewsPage());
      case AppRoutes.saved:
        return CupertinoPageRoute(builder: (_) => SavedPage());
      case AppRoutes.aboutme:
        return CupertinoPageRoute(builder: (_) => ProfilePage());
      case AppRoutes.contact:
        return CupertinoPageRoute(builder: (_) => ContactPage());
      case AppRoutes.tenMinnutes:
        return CupertinoPageRoute(
            builder: (_) => TenMinutesStransformationPage());

      case AppRoutes.comment:
        if (args is ArticleModel) {
          return CupertinoPageRoute(builder: (_) => CommentPage(article: args));
        } else {
          return errorRoute();
        }

      case AppRoutes.category:
        if (args is CategoryPageArguments) {
          return CupertinoPageRoute(
              builder: (_) => CategoryPage(arguments: args));
        } else {
          return errorRoute();
        }

      case AppRoutes.tag:
        if (args is PostTag) {
          return CupertinoPageRoute(builder: (_) => TagPage(tag: args));
        } else {
          return errorRoute();
        }

      default:
    }
    return null;
  }

  static Route? errorRoute() =>
      CupertinoPageRoute(builder: (_) => const UnknownPage());
}
