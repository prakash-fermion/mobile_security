import 'package:prefs/prefs.dart';

class PrefsHelper {
  final SharedPreferences prefs;
  PrefsHelper(this.prefs);
  // Save a string value
  Future<void> saveString(String key, String value) async {
    await prefs.setString(key, value);
  }

  // Get a string value
  String? getString(String key) {
    return prefs.getString(key);
  }

  // Save a boolean value
  Future<void> saveBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  // Get a boolean value
  bool? getBool(String key) {
    return prefs.getBool(key);
  }

  // Remove a value
  Future<void> remove(String key) async {
    await prefs.remove(key);
  }

  // Clear all preferences
  Future<void> clear() async {
    await prefs.clear();
  }
}
