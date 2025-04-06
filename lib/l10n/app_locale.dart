import 'package:flutter/material.dart';
import 'package:raff/configuration/cache_keys.dart';
import 'package:raff/configuration/current_session.dart';
import 'package:raff/utils/helpers/shared_preferences_helper.dart';
import 'package:scoped_model/scoped_model.dart';

class AppLocale extends Model {
  static var shared = AppLocale._private();
  AppLocale._private();
  CurrentSession currentSession = CurrentSession();
  Locale _appLocale = const Locale('en');
  factory AppLocale() => shared;
  Locale get appLocal => _appLocale;

  void changeLanguage({String? language, bool isSave = true}) {
    if (language == null) {
      if (_appLocale == Locale('en'))
        _appLocale = const Locale('ar');
      else
        _appLocale = Locale('en');
    } else
      _appLocale = Locale(language);

    if (isSave) _saveLanguage();
    notifyListeners();
  }

  bool isArabic() {
    var currentLang = appLocal.languageCode;
    return currentLang.contains('ar');
  }

  void _saveLanguage() {
    SharedPreferencesHelper.save(
        key: CacheKeys.currentLanguage, value: isArabic() ? 'ar' : 'en');
  }
}
