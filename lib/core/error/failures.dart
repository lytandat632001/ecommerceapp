import 'package:equatable/equatable.dart';

// Lớp cơ sở (abstract class) cho tất cả các loại lỗi
// Mọi lỗi trong ứng dụng sẽ kế thừa từ lớp này
abstract class Failure extends Equatable {
  // Lỗi có thể có một thông điệp để hiển thị cho người dùng hoặc để debug
  final String message;

  const Failure([this.message = 'An unexpected error occurred']);

  @override
  List<Object?> get props => [message];
}

// Định nghĩa các loại lỗi cụ thể phổ biến
// Bạn có thể mở rộng thêm các loại lỗi khác tùy theo nhu cầu của ứng dụng

// Lỗi liên quan đến server (API trả về lỗi, lỗi mạng, ...)
class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server Error']) : super(message);
}

// Lỗi liên quan đến dữ liệu cục bộ (cache, thiết bị, ...)
class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache Error']) : super(message);
}

// Lỗi xác thực (đăng nhập sai, token hết hạn, ...)
class AuthFailure extends Failure {
  const AuthFailure([String message = 'Authentication Error']) : super(message);
}

// Lỗi kết nối mạng (không có internet, timeout, ...)
class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Network Error']) : super(message);
}

// Lỗi không tìm thấy dữ liệu (ví dụ: sản phẩm không tồn tại)
class NotFoundFailure extends Failure {
  const NotFoundFailure([String message = 'Not Found']) : super(message);
}

// Lỗi dữ liệu không hợp lệ (ví dụ: dữ liệu form không đúng định dạng)
class InvalidInputFailure extends Failure {
  const InvalidInputFailure([String message = 'Invalid Input']) : super(message);
}

// Lỗi hệ thống không xác định
class UnknownFailure extends Failure {
  const UnknownFailure([String message = 'An unknown error occurred']) : super(message);
}

// Lỗi khi người dùng hủy bỏ một hành động (ví dụ: hủy chọn ảnh, hủy đăng nhập Google)
class UserCancelledFailure extends Failure {
  const UserCancelledFailure([String message = 'User cancelled the operation']) : super(message);
}