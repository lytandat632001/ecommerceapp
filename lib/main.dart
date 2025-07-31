import 'package:ecommerceapp/di/injector.dart' as di;
import 'package:ecommerceapp/features/presentation/blocs/auth_bloc.dart';
import 'package:ecommerceapp/features/presentation/pages/auth_page.dart';
import 'package:ecommerceapp/features/presentation/pages/home_screen.dart';
import 'package:ecommerceapp/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter
import 'firebase_options.dart';


// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(title: Text('Home')),
//       body: Center(
//         child: Text('Welcome to Home Screen!'),
//       ),
//     );
//   }
// }

// Cấu hình GoRouter
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(), // Màn hình khởi đầu là Splash Screen
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(), // Màn hình xác thực
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(), // Màn hình chính sau khi đăng nhập
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.configureDependencies(); // Khởi tạo các phụ thuộc
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( // Sử dụng MultiBlocProvider nếu bạn có nhiều BLoC cấp cao
      providers: [
        BlocProvider(
          create: (context) => di.getIt<AuthBloc>(), // Lấy AuthBloc từ GetIt
        ),
        // Thêm các Bloc khác ở đây nếu có (ví dụ: ThemeBloc, UserBloc)
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
        title: 'Your Ecommerce App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}