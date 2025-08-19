import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationDetailScreen extends StatelessWidget {
  final NotificationModel notification;

  NotificationDetailScreen({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông báo'),
        backgroundColor: Color(0xFF1A68B4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
  notification.title,
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),


            SizedBox(height: 8),
            Text(
              '(${notification.time})',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Text(notification.content, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            ...notification.links.map(
              (link) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  link,
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
