import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
import 'notification_list_screen.dart';
import 'schedule_screen.dart';
import 'user.dart';
import 'gv_report_screen.dart';

void main() {
  runApp(HuscSolving());
}

class HuscSolving extends StatefulWidget {
  const HuscSolving({super.key});

  @override
  State<HuscSolving> createState() => _HuscSolvingState();
}

class _HuscSolvingState extends State<HuscSolving> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePageGV(), debugShowCheckedModeBanner: false);
  }
}

class HomePageGV extends StatelessWidget {
  const HomePageGV({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F6FC),
      body: Column(
        children: [
          // Header blue with logo + app name + profile icon
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF1A68B4),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            padding: EdgeInsets.fromLTRB(16, 40, 16, 12),
            child: Row(
              children: [
                Image.asset('assets/logo_husc.png', width: 45, height: 45),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'HUSC SOLVING',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Sáng tạo - Nhân văn - Thích ứng',
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color.fromARGB(179, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentProfilePage(),
                      ),
                    );
                  },
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ],
            ),
          ),

          // Image of university
          Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/husc_building.png',
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Feature buttons
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
                children: [
                  _buildFeatureBox(
                    icon: Icons.report,
                    label: 'Phản ánh\nhiện trường',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReportPage()),
                      );
                    },
                  ),
                  _buildFeatureBox(
                    icon: Icons.calendar_month,
                    label: 'Thời khóa\nbiểu',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SchedulePage()),
                      );
                    },
                  ),
                  _buildFeatureBox(
                    icon: Icons.notifications,
                    label: 'Thông báo',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationPage(),
                        ),
                      );
                    },
                  ),
                  _buildFeatureBox(
                    icon: Icons.message,
                    label: 'Tin nhắn',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MessagePage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureBox({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    int badge = 0,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 40, color: Color(0xFF1A68B4)),
                  SizedBox(height: 8),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            if (badge > 0)
              Positioned(
                top: 8,
                right: 12,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(minWidth: 24, minHeight: 24),
                  child: Center(
                    child: Text(
                      '$badge',
                      style: TextStyle(color: Colors.white, fontSize: 12),
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

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ReportScreen(); // ❌   không bao MaterialApp nữa
  }
}

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScheduleScreen(); // ❌   không bao MaterialApp nữa
  }
}

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotificationListScreen(); // ❌ không bao MaterialApp nữa
  }
}

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tin nhắn"),
        backgroundColor: Color(0xFF1A68B4),
      ),
      body: Center(
        child: Text("Đây là trang tin nhắn", style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
