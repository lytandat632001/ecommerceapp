import 'package:ecommerceapp/core/error/failures.dart';
import 'package:ecommerceapp/features/auth/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable()
// Use case cho việc đăng nhập bằng Google
class SignInWithGoogleUseCase {
  final AuthRepository repository; // Sử dụng AuthRepository để thực hiện các thao tác xác thực

  SignInWithGoogleUseCase(this.repository);

  // Hàm call cho phép lớp được gọi như một hàm (e.g., signInWithGoogleUseCase())
  Future<Either<Failure, User>> call() async {
    return await repository.signInWithGoogle();
  }
}