import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/schedule_model.dart';

class ScheduleService {
  static Future<Map<String, Map<String, Lesson?>>> fetchCurrentWeekSchedule(int currentWeek) async {
    final url = Uri.parse('https://api.truonghoc.vn/schedule?week=$currentWeek');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;

      return _parseWeeklyData(data);
    } else {
      throw Exception('Failed to load current week schedule');
    }
  }

  static Future<Map<int, Map<String, Map<String, Lesson?>>>> fetchWholeSemesterSchedule() async {
    final url = Uri.parse('https://api.truonghoc.vn/schedule/whole-semester');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;

      Map<int, Map<String, Map<String, Lesson?>>> loadedSchedules = {};

      data.forEach((weekStr, weekData) {
        final int week = int.parse(weekStr);
        final Map<String, dynamic> weekMap = weekData;

        loadedSchedules[week] = _parseWeeklyData(weekMap);
      });

      return loadedSchedules;
    } else {
      throw Exception('Failed to load whole semester schedule');
    }
  }

  static Map<String, Map<String, Lesson?>> _parseWeeklyData(Map<String, dynamic> data) {
    Map<String, Map<String, Lesson?>> schedule = {};

    data.forEach((sessionName, daysData) {
      final Map<String, dynamic> daysMap = daysData;
      Map<String, Lesson?> dayLessons = {};

      daysMap.forEach((dayName, lessonData) {
        if (lessonData == null) {
          dayLessons[dayName] = null;
        } else {
          dayLessons[dayName] = Lesson.fromJson(lessonData);
        }
      });

      schedule[sessionName] = dayLessons;
    });

    return schedule;
  }
}
