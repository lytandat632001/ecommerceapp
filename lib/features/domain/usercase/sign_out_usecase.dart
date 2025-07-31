import 'package:dartz/dartz.dart';
import 'package:ecommerceapp/core/error/failures.dart';
import 'package:ecommerceapp/features/auth/data/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
// Use case cho việc đăng xuất
class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.signOut(); // Gọi phương thức signOut từ AuthRepository
  }
}