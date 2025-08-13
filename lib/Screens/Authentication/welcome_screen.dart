import 'package:flutter/material.dart';
import 'package:library_app/Screens/Authentication/login_web_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/peakpx.jpg',
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ), // thêm logo vào assets
            const SizedBox(height: 30,),
            const Text("Choose your role" , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold , color: Colors.white),),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginWebScreen(role: "student"),
                  ),
                );
              },
              child: const Text("Sinh Viên"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginWebScreen(role: "teacher"),
                  ),
                );
              },
              child: const Text("Giảng Viên"),
            ),
          ],
        ),
      ),
    );
  }
}
