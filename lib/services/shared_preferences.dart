// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

enum PreferenceKey {
  phoneNumber,
  isLoggedIn,
}

class SharedStorageService {
  static late final SharedPreferences _prefs;

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<bool> setString(PreferenceKey key, String value) async {
    return await _prefs.setString(key.toString(), value);
  }

  static Future<bool> setBool(PreferenceKey key, bool value) async {
    return await _prefs.setBool(key.toString(), value);
  }

  static String getString(PreferenceKey key, [String defValue = '']) {
    return _prefs.getString(key.toString()) ?? defValue;
  }

  static bool getBool(PreferenceKey key, [bool defValue = false]) {
    return _prefs.getBool(key.toString()) ?? defValue;
  }

  static Future<bool> clear() async {
    return await _prefs.clear();
  }
}
