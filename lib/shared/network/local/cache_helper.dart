import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> putBoolean(
    String key,
    bool value,
  ) async {
    return await sharedPreferences?.setBool(key, value);
  }

  static dynamic getData(
    String key,
  ) {
    return sharedPreferences?.get(key);
  }

  static dynamic getFavData(
    String key,
  ) {
    return sharedPreferences?.get(key);
  }

  static Future<bool?> saveData(
    String key,
    bool value,
  ) async {
    //if (value is String) return await sharedPreferences?.setString(key, value);
    // if (value is int) return await sharedPreferences?.setInt(key, value);
    if (value is bool) return await sharedPreferences?.setBool(key, value);
    // return await sharedPreferences?.setDouble(key, value);
  }

  static Future<bool?> saveLocation(String key, String location) async {
    if (location is String)
      return await sharedPreferences?.setString(key, location);
  }

  static Future<bool?> removeData(@required String key) async {
    return await sharedPreferences?.remove(key);
  }

  static Future<bool?> saveFavData(
    String key,
    String value,
    String image,
    String desc,
    String add,
    String price,
    bool type,
  ) async {
    if (value is String) return await sharedPreferences?.setString(key, value);
    if (image is String) return await sharedPreferences?.setString(key, image);
    if (desc is String) return await sharedPreferences?.setString(key, desc);
    if (add is String) return await sharedPreferences?.setString(key, add);
    if (price is String) return await sharedPreferences?.setString(key, price);
    if (type is bool) return await sharedPreferences?.setBool(key, type);

    //if (value is bool) return await sharedPreferences?.setBool(key, value);
    // return await sharedPreferences?.setDouble(key, value);
  }
}
