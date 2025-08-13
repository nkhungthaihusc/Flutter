import 'package:flutter/material.dart';
import 'user.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Giả sử khi nhấn login, bạn vào trang StudentProfilePage
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const StudentProfilePage(),
              ),
            );
          },
          child: const Text('Đăng nhập'),
        ),
      ),
    );
  }
}
