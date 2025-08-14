import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/notification_model.dart';

class NotificationService {
  static Future<List<NotificationModel>> fetchNotifications() async {
    // 🔁 TODO: Dùng API thật sau này
    // final response = await http.get(Uri.parse('https://your-api.com/notifications'));

    // Giả lập dữ liệu từ mock JSON
    await Future.delayed(Duration(seconds: 1)); // giả lập loading

    final mockJson = [
      {
        "title": "Thông báo về lịch thi học kỳ 3, năm học 2024-2025.",
        "time": "30/07/2025 10:00",
        "content": "Nhà trường thông báo đến sinh viên lịch thi học kỳ 3, năm học 2024-2025.",
        "links": ["Lịch thi học kỳ 3, năm học 2024 - 2025.", "Hướng dẫn đăng ký thi lại."],
      },
      {
        "title": "Thông báo về việc đăng ký học phần học kỳ 3.",
        "time": "29/07/2025 14:20",
        "content": "Sinh viên cần đăng ký học phần trước ngày 05/08/2025 để đảm bảo quyền lợi.",
        "links": [],
      },
      // ... bạn có thể cắt ngắn hoặc giữ toàn bộ mock data ở đây
    ];

    return mockJson.map((json) => NotificationModel.fromJson(json)).toList();

    // SAU NÀY DÙNG API THẬT:
    // if (response.statusCode == 200) {
    //   final List<dynamic> jsonData = json.decode(response.body);
    //   return jsonData.map((json) => NotificationModel.fromJson(json)).toList();
    // } else {
    //   throw Exception('Failed to load notifications');
    // }
  }
}
