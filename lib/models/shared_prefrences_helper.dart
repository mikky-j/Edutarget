import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  Future<String> readString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final String value = prefs.getString(key) ?? "null";
    return value;
  }

  Future<int> readInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final int value = prefs.getInt(key) ?? 0;
    return value;
  }

  Future<double> readDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final double value = prefs.getDouble(key) ?? 0.0;
    return value;
  }

  Future<bool> readBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final bool value = prefs.getBool(key) ?? "null";
    return value;
  }

  Future<void> saveInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
    print("saved");
  }

  Future<void> saveDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
    print("saved");
  }

  Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print("saved");
  }

  Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
    print("saved");
  }
}
