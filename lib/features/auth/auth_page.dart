import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:google_sign_in/google_sign_in.dart'; // Import Google Sign In
import 'package:go_router/go_router.dart'; // Import GoRouter

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  // Hàm xử lý đăng nhập Google
  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      // Khởi tạo GoogleSignIn instance
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Thực hiện quá trình đăng nhập Google trên thiết bị
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // Người dùng hủy đăng nhập hoặc xảy ra lỗi
        print('Đăng nhập Google bị hủy hoặc không thành công.');
        return;
      }

      // Lấy thông tin xác thực (authentication) từ tài khoản Google đã đăng nhập
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Tạo một Firebase credential từ thông tin xác thực Google
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Đăng nhập vào Firebase với credential Google
      // Điều này sẽ liên kết tài khoản Google với Firebase Auth
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      print('Đăng nhập thành công với Google: ${userCredential.user?.displayName}');

      // Điều hướng đến màn hình Home sau khi đăng nhập thành công
      // `mounted` được dùng để kiểm tra xem widget còn trong cây widget hay không trước khi gọi context.go
      if (context.mounted) {
        context.go('/home');
      }

    } on FirebaseAuthException catch (e) {
      // Xử lý các lỗi cụ thể từ Firebase Auth
      print('Lỗi Firebase Auth khi đăng nhập Google: ${e.code} - ${e.message}');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi đăng nhập: ${e.message}')),
        );
      }
    } catch (e) {
      // Xử lý các lỗi chung khác
      print('Lỗi không xác định khi đăng nhập Google: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi đăng nhập: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Chào mừng đến với Your Ecommerce App!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80),
            ElevatedButton.icon(
              onPressed: () => _handleGoogleSignIn(context), // Gọi hàm đăng nhập Google khi nút được nhấn
              icon: SvgPicture.asset(
                'assets/icons/google.svg',
                height: 28,
                width: 28,
              ),
              label: const Text(
                'Đăng nhập bằng Google',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.grey, width: 1.5),
                ),
                elevation: 3,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Hoặc đăng nhập bằng phương thức khác...',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}