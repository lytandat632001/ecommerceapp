import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import User từ firebase_auth

// Lớp cơ sở cho tất cả các trạng thái Auth
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// Trạng thái khởi tạo ban đầu
class AuthInitial extends AuthState {
  const AuthInitial();
}

// Trạng thái khi đang xử lý (ví dụ: đang đăng nhập)
class AuthLoading extends AuthState {
  const AuthLoading();
}

// Trạng thái khi đăng nhập/đăng xuất thành công
class AuthSuccess extends AuthState {
  final User? user; // Có thể null nếu là đăng xuất

  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

// Trạng thái khi có lỗi xảy ra
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}