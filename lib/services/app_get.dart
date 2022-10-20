import '../my_library.dart';

class AppGet extends GetxController {
  Locale localeUse = const Locale('ar', 'AE');

  setUpdateLocale({required Locale locale}) {
    if (locale == const Locale('en', 'US')) {
      AppPreferences().saveLocale(languageCode: 'en', countryCode: 'US');
    } else if (locale == const Locale('ar', 'AE')) {
      AppPreferences().saveLocale(languageCode: 'ar', countryCode: 'AE');
    } else if (locale == const Locale('fr', 'FR')) {
      AppPreferences().saveLocale(languageCode: 'fr', countryCode: 'FR');
    } else if (locale == const Locale('ru', 'RU')) {
      AppPreferences().saveLocale(languageCode: 'ru', countryCode: 'RU');
    } else if (locale == const Locale('hi', 'IN')) {
      AppPreferences().saveLocale(languageCode: 'hi', countryCode: 'IN');
    } else if (locale == const Locale('fil', 'PH')) {
      AppPreferences().saveLocale(languageCode: 'fil', countryCode: 'PH');
    } else if (locale == const Locale('zh', 'CN')) {
      AppPreferences().saveLocale(languageCode: 'zh', countryCode: 'CN');
    } else if (locale == const Locale('ur', 'PK')) {
      AppPreferences().saveLocale(languageCode: 'ur', countryCode: 'PK');
    }
    Get.updateLocale(locale);
  }
}
