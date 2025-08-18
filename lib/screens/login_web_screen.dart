import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/auth_storage.dart';
// import 'package:library_app/Screens/Authentication/dashboard_screen.dart';
// import 'package:library_app/Screens/Authentication/user_screen.dart';
// import 'package:library_app/Screens/Repositories/auth_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'HomePage.dart';

class LoginWebScreen extends StatefulWidget {
  final String role;
  const LoginWebScreen({super.key, required this.role});

  @override
  State<LoginWebScreen> createState() => _LoginWebScreenState();
}

class _LoginWebScreenState extends State<LoginWebScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // ✅ Bắt buộc cho Android/iOS
    // if (Platform.isAndroid) {
    //   WebViewPlatform.instance = S;
    // }

    String loginUrl =
        "https://ums-dev.husc.edu.vn/ApiGateway/auth/account/authorize"
        "?app_id=TestApp&redirect_uri=http://127.0.0.1&role=${widget.role}";

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith("http://127.0.0.1")) {
              Uri uri = Uri.parse(request.url);
              String? code = uri.queryParameters["code"];
              String? host = uri.queryParameters["host"];

              if (code != null && host != null) {
                _verifyCode(code, host);
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(loginUrl));
  }

  Future<void> _verifyCode(String code, String host) async {
    // 1. Tạo time request
    DateTime VNtime = DateTime.now().toUtc().add(const Duration(hours: 7));
    String time = DateFormat('yyyyMMddHHmmss').format(VNtime);

    // 2. Tạo signature
    String secretKey = "1234567890";
    String appID = "TestApp";
    String raw = "$appID$secretKey$time";
    String signature = md5.convert(utf8.encode(raw)).toString();
    print("Signature: $signature");
    print("Code: $code");
    print("Time: $time");

    // 3. Gửi request
    final verifyUrl = Uri.parse(
      "https://ums-dev.husc.edu.vn/ApiGateway/auth/account/verify?code=$code&time=$time&signature=$signature",
    );
    print("Verify URL: $verifyUrl");

    try {
      final response = await http.post(verifyUrl);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("Response: ${response.body}");
        print('Access Token: ${jsonData["Data"]["Token"]}');
        String token = await jsonData["Data"]["Token"];
        await AuthStorage.saveDataLogin(
          appId: appID,
          time: time,
          signature: signature,
          token: token,
        );

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
          );
        }
      } else {
        print("Failed to verify code. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi kết nối: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Đăng Nhập ${widget.role}")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
