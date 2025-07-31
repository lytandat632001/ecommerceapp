import 'package:ecommerceapp/core/error/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart'; // Cần thêm package dartz

// Định nghĩa một interface cho AuthRepository
// Nó sẽ trả về Either<Failure, T> để xử lý lỗi một cách rõ ràng
abstract class AuthRepository {
  Future<Either<Failure, User>> signInWithGoogle();
  Future<Either<Failure, void>> signOut();
  Stream<User?> get authStateChanges;
}