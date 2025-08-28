import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/students_models/user_profile_model.dart';
import 'package:flutter_application_1/repositories/auth_storage.dart';
import 'package:intl/intl.dart';


class ApiRepository{

  static Future<dynamic> setHeaders (String uri) async{
    final dio = Dio();

    String secretKey = "1234567890";
    final appId = await AuthStorage.getAppId();
    DateTime VNtime = DateTime.now().toUtc().add(const Duration(hours: 7));
    final time = DateFormat('yyyyMMddHHmmss').format(VNtime);
    // print(time);
    String raw = "$appId$secretKey$time";
    final signature = md5.convert(utf8.encode(raw)).toString();
    // print(signature);
    final token = await AuthStorage.getToken();

    final res = await dio.get(uri,
        options: Options(
            headers: {
              "Content-Type": "application/json",
              "ums-application": appId,
              "ums-time": time,
              "ums-signature": signature,
              "ums-token": token
            }
        )
    );
    return res;
  }

  static Future<StudentProfile> getStudentProfile() async{
    try{

      final res = await setHeaders("https://ums-dev.husc.edu.vn/ApiGateway/account/v1/profile");
      final data = res.data["Data"];
      final result = StudentProfile.fromMap(data);
      return result;
    } catch (e){
      print(e);
      throw e;
    }
  }

  static Future<void> getStudentSchedule() async{
    try{
      String? StudentID = await StudentStorges.getStudentID();
      String? mahocki = await StudentStorges.getMaHocKi();
      final res = await setHeaders("https://ums-dev.husc.edu.vn/ApiGateway/undergraduate-services/v1/timetable/by-student?studentId=$StudentID&semester=$mahocki");
      print("abc");
    } catch (e){
      print(e);
      throw e;
    }
  }


}