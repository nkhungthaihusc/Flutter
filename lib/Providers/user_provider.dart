import 'package:flutter/material.dart';
import 'package:library_app/Models/user_profile_model.dart';
import 'package:library_app/Screens/Repositories/api_repositories.dart';

class UserProvider extends ChangeNotifier{
  Future<StudentProfile> getUserCurruent() async{
    StudentProfile result = await ApiResponse.getProfileUser();
    return result;
  }
}