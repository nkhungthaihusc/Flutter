import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const _appIdKey = "ums-application";
  static const _tokenKey = "ums-token";
  static const _role = "ums-role";

  static Future<void> saveDataLogin({
    required String appId,
    required String token,
    required String role,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_appIdKey, appId);
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_role, role);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_role);
  }

  static Future<String?> getAppId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_appIdKey);
  }
}

class StudentStorges{
  static const _StudentID = "Student-id";
  static const _maHocKi = "MaHocKi";

  static Future<void> saveStudentStorages({
    required String StudentID,
    required String mahocki,
  } ) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_StudentID , StudentID);
    await prefs.setString(_maHocKi, mahocki);
  }

  static Future<String?> getStudentID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_StudentID);
  }

  static Future<String?> getMaHocKi() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_maHocKi);
  }
}
