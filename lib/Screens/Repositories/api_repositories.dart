import 'package:dio/dio.dart';
import 'package:library_app/Models/user_profile_model.dart';
import 'package:library_app/Screens/Repositories/auth_storage.dart';

class ApiResponse{

  static Future<StudentProfile> getProfileUser() async{
    try{
      final dio = Dio();

      final appId = await AuthStorage.getAppId();
      final time = await AuthStorage.getTime();
      final signature = await AuthStorage.getSignature();
      final token = await AuthStorage.getToken();

      final res = await dio.get("https://ums-dev.husc.edu.vn/ApiGateway/account/v1/profile",
          options:
          Options(
              headers: {
                "Content-Type": "application/json",
                "ums-application": appId,
                "ums-time": time,
                "ums-signature": signature,
                "ums-token": token
              }
          )
      );
      final data = res.data["Data"];
      final result = StudentProfile.fromMap(data);
      return result;
    } catch (e){
      print(e);
      throw e;
    }
  }
}