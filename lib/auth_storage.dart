import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const _appIdKey = "ums-application";
  static const _timeKey = "ums-time";
  static const _signatureKey = "ums-signature";
  static const _tokenKey = "ums-token";

  static Future<void> saveDataLogin({
    required String appId,
    required String time,
    required String signature,
    required String token,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_appIdKey, appId);
    await prefs.setString(_timeKey, time);
    await prefs.setString(_signatureKey, signature);
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<String?> getTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_timeKey);
  }

  static Future<String?> getSignature() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_signatureKey);
  }

  static Future<String?> getAppId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_appIdKey);
  }
}
