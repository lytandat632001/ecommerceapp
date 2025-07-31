import 'package:equatable/equatable.dart';

// Lớp cơ sở cho tất cả các sự kiện Auth
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// Sự kiện yêu cầu đăng nhập bằng Google
class AuthSignInWithGoogleEvent extends AuthEvent {
  const AuthSignInWithGoogleEvent();
}

// Sự kiện yêu cầu đăng xuất
class AuthSignOutEvent extends AuthEvent {
  const AuthSignOutEvent();
}

// Sự kiện để lắng nghe trạng thái xác thực từ Firebase (nếu bạn muốn BLoC xử lý)
// class AuthUserChangedEvent extends AuthEvent {
//   final User? user;
//   const AuthUserChangedEvent(this.user);

//   @override
//   List<Object> get props => [user ?? 'null'];
// }