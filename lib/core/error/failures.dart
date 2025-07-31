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
  const ServerFailure([super.message = 'Server Error']);
}

// Lỗi liên quan đến dữ liệu cục bộ (cache, thiết bị, ...)
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache Error']);
}

// Lỗi xác thực (đăng nhập sai, token hết hạn, ...)
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication Error']);
}

// Lỗi kết nối mạng (không có internet, timeout, ...)
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network Error']);
}

// Lỗi không tìm thấy dữ liệu (ví dụ: sản phẩm không tồn tại)
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Not Found']);
}

// Lỗi dữ liệu không hợp lệ (ví dụ: dữ liệu form không đúng định dạng)
class InvalidInputFailure extends Failure {
  const InvalidInputFailure([super.message = 'Invalid Input']);
}

// Lỗi hệ thống không xác định
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unknown error occurred']);
}

// Lỗi khi người dùng hủy bỏ một hành động (ví dụ: hủy chọn ảnh, hủy đăng nhập Google)
class UserCancelledFailure extends Failure {
  const UserCancelledFailure([super.message = 'User cancelled the operation']);
}