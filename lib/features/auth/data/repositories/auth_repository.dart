import 'package:ecommerceapp/core/error/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

// Định nghĩa một interface (abstract class) cho AuthRepository
// Interface này định nghĩa "hợp đồng" mà AuthRepositoryImpl (trong Data Layer) phải triển khai.
// Nó chỉ rõ những gì AuthRepository có thể làm mà không quan tâm đến cách nó làm.
abstract class AuthRepository {
  // Phương thức đăng nhập bằng Google
  // Trả về Either: bên trái là Failure (nếu lỗi), bên phải là User (nếu thành công)
  Future<Either<Failure, User>> signInWithGoogle();

  // Phương thức đăng xuất
  // Trả về Either: bên trái là Failure (nếu lỗi), bên phải là void (nếu thành công)
  Future<Either<Failure, void>> signOut();

  // Stream để lắng nghe sự thay đổi trạng thái xác thực của người dùng
  Stream<User?> get authStateChanges; // Đây là nơi bạn có thể lắng nghe sự thay đổi trạng thái đăng nhập của người dùng
}