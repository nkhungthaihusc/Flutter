import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/students_models/user_profile_model.dart';
import 'package:flutter_application_1/providers/student_provider.dart';
import 'package:flutter_application_1/repositories/auth_storage.dart';
import 'package:provider/provider.dart';
import 'notification_list_screen.dart';
import 'schedule_screen.dart';
import 'user.dart';
import 'report_screen.dart';

void main() {
  runApp(HuscSolving());
}

class HuscSolving extends StatelessWidget {
  const HuscSolving({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePageSV(), debugShowCheckedModeBanner: false);
  }
}

class HomePageSV extends StatefulWidget {
  const HomePageSV({super.key});

  @override
  State<HomePageSV> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageSV> {
  QuaTrinhHoc? selectedQuaTrinhHoc;
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
          SizedBox(height: 15),

          FutureBuilder(
            future: context.read<StudentProvider>().getUserCurrent(),
            initialData: null,
            builder: (BuildContext context , AsyncSnapshot snapshot){
              if (snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data == null){
                return Center(
                  child: Text("No data"),
                );
              }
              if (snapshot.error == true){
                return Center(
                  child: Text("Data err"),
                );
              }

              final StudentProfile student = snapshot.data as StudentProfile;
              final List<QuaTrinhHoc> quatrinhhoc = student.nganhHoc.quaTrinhHoc;
                  return Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              PopupMenuButton<QuaTrinhHoc>(
                                onSelected: (value) async {
                                  setState(() {
                                    selectedQuaTrinhHoc = value;
                                  });
                                  await StudentStorges.saveStudentStorages(
                                      StudentID: student.maSinhVien,
                                      mahocki: value.maHocKy);
                                },
                                itemBuilder: (context) => quatrinhhoc.map((e) {
                                  return PopupMenuItem<QuaTrinhHoc>(
                                    value: e, // ví dụ: "2024-2025.1"
                                    child: Text("Học kỳ ${e.maHocKy}"),
                                  );
                                }).toList(),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.calendar_month, color: Colors.blue),
                                      SizedBox(width: 8),
                                      Text("Chọn kì tác nghiệp"),
                                      Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            selectedQuaTrinhHoc?.maHocKy == null
                                ? "Chưa chọn kì học"
                                : "Bạn chọn: ${selectedQuaTrinhHoc?.maHocKy}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  );
                },
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    selectedQuaTrinhHoc?.tenNganh == null
                        ? "Chưa chọn kì học"
                        : "${selectedQuaTrinhHoc?.tenNganh}",
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    selectedQuaTrinhHoc?.tenKhoaHoc == null
                        ? "Chưa chọn kì học"
                        : "${selectedQuaTrinhHoc?.tenKhoaHoc}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
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
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportScreen(); // ❌   không bao MaterialApp nữa
  }
}

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScheduleScreen(); // ❌   không bao MaterialApp nữa
  }
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListScreen(); // ❌ không bao MaterialApp nữa
  }
}

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

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
