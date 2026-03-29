import 'package:shared_preferences/shared_preferences.dart';

class SharedHandler {
  SharedHandler._internal();
  static final SharedHandler instance = SharedHandler._internal();

  late SharedPreferences _preferences;

  /// لازم تتنادي في main()
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // ================== STRING ==================
  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  // ================== BOOL ==================
  Future<void> setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _preferences.getBool(key) ?? defaultValue;
  }

  // ================== Data ==================
  Future<void> setData(String key, String value) async {

    await _preferences.setString(key, value);
  }

  String? readData(String key) {

    return _preferences.getString(key);
  }

  Future<void> removeData(String key) async {
    await _preferences.remove(key);
  }
  // String
  Future<void> saveData({required String key, required String value}) async {
    final prefs = await _preferences;
    await prefs.setString(key, value);
  }

  // ================== REMOVE ==================
  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  Future<void> clear() async {
    await _preferences.clear();
  }
}
