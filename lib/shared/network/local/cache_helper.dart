import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  static initCache() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //save data
  static Future<bool> save({required String key, required dynamic data}) async {
    if (data is String) return await _prefs.setString(key, data);
    if (data is int) return await _prefs.setInt(key, data);
    if (data is double) return await _prefs.setDouble(key, data);
    return await _prefs.setBool(key, data);
  }

  //get data
  static Future<dynamic> get({required String key}) async => _prefs.get(key);

  //remove data
  static Future<bool> remove({required String key}) async => _prefs.remove(key);
}
