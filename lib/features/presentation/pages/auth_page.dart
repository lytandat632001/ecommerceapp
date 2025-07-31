import 'package:ecommerceapp/features/presentation/blocs/auth_bloc.dart';
import 'package:ecommerceapp/features/presentation/blocs/auth_event.dart';
import 'package:ecommerceapp/features/presentation/blocs/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Bloc
import 'package:go_router/go_router.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
        centerTitle: true,
        elevation: 0,
      ),
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
        ),
      ),
    );
  }
}