<<<<<<< HEAD
import 'package:ecommerceapp/features/presentation/blocs/auth_bloc.dart';
import 'package:ecommerceapp/features/presentation/blocs/auth_event.dart';
import 'package:ecommerceapp/features/presentation/blocs/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Bloc
import 'package:go_router/go_router.dart';

=======
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:google_sign_in/google_sign_in.dart'; // Import Google Sign In
import 'package:go_router/go_router.dart'; // Import GoRouter
>>>>>>> feature/google-signin

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

<<<<<<< HEAD
=======
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

>>>>>>> feature/google-signin
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
        centerTitle: true,
        elevation: 0,
      ),
<<<<<<< HEAD
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            if (state.user != null) {
              // Đăng nhập thành công, điều hướng đến màn hình chính
              context.go('/home');
            } else {
              // Đăng xuất thành công, có thể không làm gì hoặc hiển thị thông báo
              print('User logged out.');
            }
          } else if (state is AuthError) {
            // Hiển thị thông báo lỗi
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Lỗi đăng nhập: ${state.message}')),
            );
          }
        },
        child: Padding(
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
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final bool isLoading = state is AuthLoading;
                  return ElevatedButton.icon(
                    onPressed: isLoading
                        ? null // Vô hiệu hóa nút khi đang tải
                        : () {
                            // Gửi sự kiện đăng nhập Google đến AuthBloc
                            context.read<AuthBloc>().add(const AuthSignInWithGoogleEvent());
                          },
                    icon: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ),
                          )
                        : SvgPicture.asset(
                            'assets/icons/google.svg',
                            height: 28,
                            width: 28,
                          ),
                    label: Text(
                      isLoading ? 'Đang đăng nhập...' : 'Đăng nhập bằng Google',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                  );
                },
              ),
              const SizedBox(height: 30),
              const Text(
                'Hoặc đăng nhập bằng phương thức khác...',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
=======
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
>>>>>>> feature/google-signin
        ),
      ),
    );
  }
}