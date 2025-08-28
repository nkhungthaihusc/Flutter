import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/students_models/schedule_model.dart';
import 'package:flutter_application_1/models/students_models/user_profile_model.dart';
import 'package:flutter_application_1/repositories/api_repository.dart';


class StudentProvider extends ChangeNotifier{
  Future<StudentProfile> getUserCurrent() async {
    StudentProfile result = await ApiRepository.getStudentProfile();
    return result;
  }
  Future<void> getSchedule() async{
    await ApiRepository.getStudentSchedule();
  }
}