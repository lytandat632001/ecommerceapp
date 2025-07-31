// File: lib/home_screen.dart
import 'package:ecommerceapp/features/presentation/blocs/auth_bloc.dart';
import 'package:ecommerceapp/features/presentation/blocs/auth_event.dart';
import 'package:ecommerceapp/features/presentation/blocs/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Để hiển thị thông tin user


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lắng nghe trạng thái AuthBloc để điều hướng khi đăng xuất
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess && state.user == null) {
          // Nếu AuthSuccess và user là null (đã đăng xuất), điều hướng về màn hình auth
          context.go('/auth');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi đăng xuất: ${state.message}')),
          );
        }
      },
      child: Scaffold(
   
        appBar: AppBar(
          title: const Text('Trang Chủ'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                // Gửi sự kiện đăng xuất đến AuthBloc
                context.read<AuthBloc>().add(const AuthSignOutEvent());
              },
              tooltip: 'Đăng xuất',
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Hiển thị thông tin người dùng (từ Firebase Auth trực tiếp hoặc từ AuthBloc State nếu bạn muốn truyền User qua BLoC)
              // Để đơn giản, hiện tại lấy trực tiếp từ Firebase Auth
              if (FirebaseAuth.instance.currentUser != null) ...[
                Text(
                  'Chào mừng, ${FirebaseAuth.instance.currentUser!.displayName ?? FirebaseAuth.instance.currentUser!.email ?? 'Người dùng'}!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                if (FirebaseAuth.instance.currentUser!.photoURL != null)
                  CircleAvatar(
                    backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
                    radius: 50,
                  ),
                const SizedBox(height: 20),
                Text('UID: ${FirebaseAuth.instance.currentUser!.uid}'),
                Text('Email: ${FirebaseAuth.instance.currentUser!.email ?? 'N/A'}'),
              ] else
                const Text('Bạn chưa đăng nhập.', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthSignOutEvent());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Đăng xuất'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}