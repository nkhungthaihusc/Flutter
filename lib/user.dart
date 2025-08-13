import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/main.dart'; // Để dùng SplashScreen từ file main.dart
import 'package:flutter_application_1/login_page.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  // Dữ liệu giả lập
  final String fullName = "NGUYỄN VĂN A";
  final Map<String, String> info = const {
    "Mã sinh viên:": "23T1010101",
    "Giới tính:": "Nam",
    "Ngày sinh:": "01/01/2005",
    "Nơi sinh:": "Huế",
    "Quốc tịch:": "Việt Nam",
    "Dân tộc:": "Kinh",
    "Tôn giáo:": "Không",
    "Số CCCD:": "012345678901",
    "Số điện thoại:": "0987654321",
    "Email:": "23T1010101@husc.edu.vn",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: SafeArea(
        child: Column(
          children: [
            // Header với gradient và back arrow + tiêu đề
            Container(
              height: 70,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0F5FA8), Color(0xFF1976D2)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Tài khoản",
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Phần content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    // Avatar và tên
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          fullName,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),

                    // Thông tin chi tiết
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: info.entries.map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: e.key + " ",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: e.value,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 55),

                    // Nút đăng xuất
                    SizedBox(
                      width: 280,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Xác nhận đăng xuất'),
                                content: const Text(
                                  'Bạn có chắc chắn muốn đăng xuất không?',
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Không'),
                                    onPressed: () {
                                      Navigator.of(
                                        context,
                                      ).pop(); // Đóng dialog
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Có'),
                                    onPressed: () {
                                      Navigator.of(
                                        context,
                                      ).pop(); // Đóng dialog
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SplashScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Đăng xuất',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
