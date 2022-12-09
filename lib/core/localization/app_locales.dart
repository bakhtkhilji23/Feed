import 'dart:ui';

class AppLocales {
  static Locale bengali = const Locale('bn', 'BD');
  static Locale english = const Locale('en', 'US');
  static Locale arabic = const Locale('ar', 'AE');
  static Locale spanish = const Locale('es', 'ES');
  static Locale hindi = const Locale('hi', 'IN');

  static List<Locale> supportedLocales = [
    english,
    bengali,
    arabic,
    spanish,
    hindi,
  ];

  /// Returns a formatted version of language
  /// if nothing is present than it will pass the locale to a string
  static String formattedLanguageName(Locale locale) {
    if (locale == bengali) {
      return 'বাংলা';
    } else if (locale == english) {
      return 'English';
    } else if (locale == arabic) {
      return 'عربي';
    } else if (locale == spanish) {
      return 'Español';
    } else if (locale == hindi) {
      return 'हिन्दी';
    } else {
      return locale.countryCode.toString();
    }
  }
}
