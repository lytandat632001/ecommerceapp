import 'package:ecommerceapp/core/error/failures.dart';
import 'package:ecommerceapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ecommerceapp/features/auth/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import User từ firebase_auth
import 'package:dartz/dartz.dart'; // Import Either để sử dụng trong các phương thức trả về
// Tạm thời định nghĩa Failure cho mục đích minh họa 
class AuthFailure extends Failure {
  final String message;
  const AuthFailure(this.message); // Thông điệp lỗi có thể được sử dụng để hiển thị cho người dùng hoặc ghi log

  @override
  List<Object?> get props => [message];
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  // final AuthLocalDataSource localDataSource;// Nếu có lưu trữ auth token cục bộ

  AuthRepositoryImpl({
    required this.remoteDataSource,
    // required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final userCredential = await remoteDataSource.signInWithGoogle();
      // Ở đây bạn có thể mapping UserCredential.user thành một AuthEntity nếu cần
      if (userCredential.user != null) {
        return Right(userCredential.user!);
      } else {
        return const Left(AuthFailure('Google Sign-In failed: No user found.'));
      }
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'An unknown Firebase Auth error occurred.'));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'An unknown Firebase Auth error occurred.'));
    } catch (e) {
      return Left(AuthFailure(e.toString())); 
    }
  }

  @override
  Stream<User?> get authStateChanges => remoteDataSource.authStateChanges;
}