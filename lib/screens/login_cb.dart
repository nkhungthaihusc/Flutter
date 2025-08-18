import 'package:flutter/material.dart';

void main() {
  runApp(StudentLoginApp());
}

class StudentLoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginScreen(), debugShowCheckedModeBanner: false);
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showError = false;
  bool _studentIdFocused = false;
  bool _passwordFocused = false;
  bool _isButtonPressed = false;
  double _opacity = 0.0;

  final FocusNode _studentIdFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _studentIdFocusNode.addListener(() {
      setState(() {
        _studentIdFocused = _studentIdFocusNode.hasFocus;
      });
    });
    _passwordFocusNode.addListener(() {
      setState(() {
        _passwordFocused = _passwordFocusNode.hasFocus;
      });
    });

    // Hiệu ứng xuất hiện mượt
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  void dispose() {
    _studentIdFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _login() {
    setState(() {
      _isButtonPressed = true;
    });

    Future.delayed(Duration(milliseconds: 150), () {
      setState(() {
        _isButtonPressed = false;

        const correctId = '123456';
        const correctPassword = 'password';

        _showError = !(_studentIdController.text == correctId &&
            _passwordController.text == correctPassword);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Ẩn bàn phím khi chạm ra ngoài
      },
      child: Scaffold(
        body: CustomPaint(
          painter: DiamondBackgroundPainter(),
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedOpacity(
                  duration: Duration(milliseconds: 600),
                  opacity: _opacity,
                  child: Container(
                    width: 350,
                    height: 400,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F6F8),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF7FBBE4),
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        ),
                      ],
                      border: Border.all(color: Color(0xFFA2C6E2), width: 8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'CÁN BỘ',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1D5CA7),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          transform: Matrix4.identity()
                            ..scale(_studentIdFocused ? 1.01 : 1.0),
                          decoration: BoxDecoration(
                            boxShadow: _studentIdFocused
                                ? [
                                    BoxShadow(
                                      color:
                                          Color(0xFF0082F1).withOpacity(0.8),
                                      blurRadius: 5,
                                      offset: Offset(0, 0),
                                      spreadRadius: 0,
                                    ),
                                  ]
                                : [],
                          ),
                          child: TextField(
                            controller: _studentIdController,
                            focusNode: _studentIdFocusNode,
                            decoration: InputDecoration(
                              labelText: 'Mã cán bộ:',
                              labelStyle: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Inter',
                                color: Colors.grey[600],
                              ),
                              floatingLabelStyle: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Inter',
                                color: Color(0xFF0082F1),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF0082F1),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFBCBCBC),
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          transform: Matrix4.identity()
                            ..scale(_passwordFocused ? 1.01 : 1.0),
                          decoration: BoxDecoration(
                            boxShadow: _passwordFocused
                                ? [
                                    BoxShadow(
                                      color:
                                          Color(0xFF0082F1).withOpacity(0.8),
                                      blurRadius: 5,
                                      offset: Offset(0, 0),
                                      spreadRadius: 0,
                                    ),
                                  ]
                                : [],
                          ),
                          child: TextField(
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Mật khẩu:',
                              labelStyle: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Inter',
                                color: Colors.grey[600],
                              ),
                              floatingLabelStyle: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Inter',
                                color: Color(0xFF0082F1),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF0082F1),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFBCBCBC),
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return SlideTransition(
                              position: animation.drive(
                                Tween(
                                  begin: Offset(0.0, -0.5),
                                  end: Offset.zero,
                                ).chain(CurveTween(curve: Curves.easeOut)),
                              ),
                              child:
                                  FadeTransition(opacity: animation, child: child),
                            );
                          },
                          child: _showError
                              ? Padding(
                                  key: ValueKey('error'),
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Thông tin đăng nhập không đúng!',
                                    style: TextStyle(
                                        color: Color(0xFFE53935), fontSize: 12),
                                  ),
                                )
                              : SizedBox(key: ValueKey('no-error')),
                        ),
                        SizedBox(height: 20),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 150),
                          transform: Matrix4.identity()
                            ..scale(_isButtonPressed ? 0.97 : 1.0),
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1A68B4),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shadowColor:
                                  Color(0xFF0082F1).withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ).copyWith(
                              elevation:
                                  MaterialStateProperty.resolveWith<double>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return 1;
                                  if (states.contains(MaterialState.hovered))
                                    return 4;
                                  return 2;
                                },
                              ),
                            ),
                            child: Text(
                              'Đăng nhập',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -20,
                  right: 20,
                  child: Image.asset(
                    'assets/logo_husc.png',
                    width: 55,
                    height: 62,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DiamondBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF006EB6),
          Color(0xFF5EA3E1),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
