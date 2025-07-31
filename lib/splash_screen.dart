import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Cần để kiểm tra trạng thái Auth
import 'package:go_router/go_router.dart'; // Cần để điều hướng

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState(); // Gọi hàm khởi tạo của lớp cha
    _checkAuthStatus(); // Gọi hàm kiểm tra trạng thái xác thực khi màn hình được khởi tạo
  }

  void _checkAuthStatus() async {
    // Đợi một chút để đảm bảo Firebase khởi tạo đầy đủ và để người dùng nhìn thấy splash screen
    await Future.delayed(const Duration(seconds: 2));

    // Lắng nghe sự thay đổi trạng thái xác thực của Firebase Auth
    // Stream `authStateChanges()` sẽ phát ra sự kiện mỗi khi trạng thái đăng nhập thay đổi (đăng nhập, đăng xuất)
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // Người dùng chưa đăng nhập, điều hướng đến màn hình Auth
        if (mounted) { // Kiểm tra nếu widget vẫn còn trong cây widget
          context.go('/auth');
        }
      } else {
        // Người dùng đã đăng nhập, điều hướng đến màn hình Home
        if (mounted) {
          context.go('/home');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(), // Hiển thị vòng tròn tiến trình
            SizedBox(height: 20),
            Text('Loading app...'),
          ],
        ),
      ),
    );
  }
}