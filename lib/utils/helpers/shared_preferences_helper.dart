import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  static Future<String> read({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key) ?? '';

    return value;
  }

  static Future<void> save({required String key, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<void> deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}