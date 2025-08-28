import 'package:flutter/material.dart';
import 'package:flutter_application_1/giangvien_screen/gv_homepage.dart';
import 'package:flutter_application_1/repositories/auth_storage.dart';
import 'package:flutter_application_1/sinhvien_screen/sv_homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_web_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller; // glow controller
  late Animation<double> _glowAnimation;

  AnimationController? _appearController; // appearance controller
  Animation<double>? _textFade;
  late Animation<Offset> _textSlide;
  late Animation<double> _button1Fade;
  late Animation<Offset> _button1Slide;
  late Animation<double> _button2Fade;
  late Animation<Offset> _button2Slide;

  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    final token = await AuthStorage.getToken();
    final role = await AuthStorage.getRole();
    print(token);
    print(role);

    if (token != null && token.isNotEmpty && role != null && role.isNotEmpty) {
      if (!mounted) return; // Kiểm tra widget có còn trong tree không
      if (role == 'student') {
        print("ashdsdasdshdhasd");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePageSV()),
        );
      } else if (role == 'teacher') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePageGV()),
        );
      } else {
        // Nếu vai trò không hợp lệ, coi như chưa đăng nhập
        _startAnimations();
      }
    } else {
      // Nếu không có token hoặc vai trò, bắt đầu animation cho màn hình chờ
      _startAnimations();
    }
  }

  void _startAnimations() {
    // Animation phát sáng chữ (glow)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 10.0,
      end: 25.0,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));

    // Appearance staggered
    _appearController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..forward();

    _textFade = CurvedAnimation(
      parent: _appearController!,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );
    _textSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _appearController!,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _button1Fade = CurvedAnimation(
      parent: _appearController!,
      curve: const Interval(0.4, 0.7, curve: Curves.easeOut),
    );
    _button1Slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _appearController!,
        curve: const Interval(0.4, 0.7, curve: Curves.easeOut),
      ),
    );

    _button2Fade = CurvedAnimation(
      parent: _appearController!,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    );
    _button2Slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _appearController!,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );
    // Phải gọi setState để build lại UI nếu ban đầu không có token và animation được khởi chạy
    if (mounted) {
      setState(() {});
    }
  }

  Widget buildAnimatedButton({
    required String text,
    required Animation<double> fadeAnimation,
    required Animation<Offset> slideAnimation,
    required VoidCallback onPressed,
  }) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9, // chiếm 75% chiều ngang màn hình
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              shadowColor: Colors.black54,
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
      _controller?.dispose();
      _appearController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Kiểm tra nếu _appearController chưa được khởi tạo (do đã điều hướng)
    // thì không build phần UI dựa vào animation nữa, có thể trả về một Container trống
    // hoặc một CircularProgressIndicator đơn giản.
    if (_appearController == null || _textFade == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: Container(
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
                    Opacity(
                      opacity: 0.3,
                      child: Image.asset('assets/logo.png', width: 220),
                    ),
                    FadeTransition(
                      opacity: _textFade!,
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
                buildAnimatedButton(
                  text: "Sinh Viên",
                  fadeAnimation: _button1Fade,
                  slideAnimation: _button1Slide,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginWebScreen(role: "student"),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),

                // Nút Giảng viên
                buildAnimatedButton(
                  text: "Giảng Viên",
                  fadeAnimation: _button2Fade,
                  slideAnimation: _button2Slide,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginWebScreen(role: "teacher"),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
