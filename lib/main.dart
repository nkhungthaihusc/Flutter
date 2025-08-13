import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'user.dart';
import 'report_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ReportScreen(), // chạy giao diện mới
      debugShowCheckedModeBanner: false,
    );
  }
}

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         textTheme: GoogleFonts.interTextTheme(), // dùng Inter cho toàn app
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }
////chạy giao diện trang user, kick đăng xuất ra màn hình đầu tiên
// void main() {
//   runApp(const MyPreviewApp());
// }

// class MyPreviewApp extends StatelessWidget {
//   const MyPreviewApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
//       home: const StudentProfilePage(), // chạy thẳng trang user
//     );
//   }
// }

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller; // glow controller
  late Animation<double> _glowAnimation;

  late AnimationController _appearController; // appearance controller
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;
  late Animation<double> _button1Fade;
  late Animation<Offset> _button1Slide;
  late Animation<double> _button2Fade;
  late Animation<Offset> _button2Slide;

  @override
  void initState() {
    super.initState();
    // Animation phát sáng chữ (glow)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 10.0,
      end: 25.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Appearance staggered
    _appearController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..forward();

    _textFade = CurvedAnimation(
      parent: _appearController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );
    _textSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _appearController,
            curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
          ),
        );

    _button1Fade = CurvedAnimation(
      parent: _appearController,
      curve: const Interval(0.4, 0.7, curve: Curves.easeOut),
    );
    _button1Slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _appearController,
            curve: const Interval(0.4, 0.7, curve: Curves.easeOut),
          ),
        );

    _button2Fade = CurvedAnimation(
      parent: _appearController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    );
    _button2Slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _appearController,
            curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    _appearController.dispose();
    super.dispose();
  }

  //Tạo nút để đỡ lặp code
  Widget buildButton(
    String title,
    Animation<double> fade,
    Animation<Offset> slide,
  ) {
    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: slide,
        child: SizedBox(
          width: 300,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: Text(
              title,
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Nền xanh full màn hình
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1976D2), Color(0xFF1976D2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Stack để chữ đè lên logo
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Logo mờ phía dưới
                    Opacity(
                      opacity: 0.3,
                      child: Image.asset('assets/logo.png', width: 220),
                    ),
                    // Chữ HUSC SOLVING với animation xuất hiện + glow
                    FadeTransition(
                      opacity: _textFade,
                      child: SlideTransition(
                        position: _textSlide,
                        child: AnimatedBuilder(
                          animation: _glowAnimation,
                          builder: (context, child) {
                            return Text(
                              "HUSC SOLVING",
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  shadows: [
                                    Shadow(
                                      blurRadius: _glowAnimation.value,
                                      color: Colors.white,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 170),

                // Nút Sinh viên
                buildButton("Sinh viên", _button1Fade, _button1Slide),
                const SizedBox(height: 20),

                // Nút Cán bộ
                buildButton("Cán bộ", _button2Fade, _button2Slide),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
