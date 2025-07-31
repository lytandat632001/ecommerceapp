import 'package:ecommerceapp/features/domain/usercase/sign_in_with_google_usecase.dart';
import 'package:ecommerceapp/features/domain/usercase/sign_out_usecase.dart';
import 'package:ecommerceapp/features/presentation/blocs/auth_event.dart';
import 'package:ecommerceapp/features/presentation/blocs/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart'; // Import User từ firebase_auth

@Injectable()
// Định nghĩa AuthBloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignOutUseCase _signOutUseCase;
  // final Stream<User?> _authStateChanges; // Nếu muốn BLoC lắng nghe auth state

  AuthBloc({
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
    required SignOutUseCase signOutUseCase,
    // required Stream<User?> authStateChanges,
  })  : _signInWithGoogleUseCase = signInWithGoogleUseCase,
        _signOutUseCase = signOutUseCase,
        // _authStateChanges = authStateChanges,
        super(const AuthInitial()) {
    // Đăng ký các hàm xử lý Event
    on<AuthSignInWithGoogleEvent>(_onSignInWithGoogleEvent);
    on<AuthSignOutEvent>(_onSignOutEvent);
    // on<AuthUserChangedEvent>(_onAuthUserChangedEvent);

    // Có thể thêm listener cho auth state changes ngay trong BLoC nếu cần
    // _authStateChanges.listen((user) {
    //   add(AuthUserChangedEvent(user));
    // });
  }

  // Hàm xử lý sự kiện đăng nhập bằng Google
  Future<void> _onSignInWithGoogleEvent(
    AuthSignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading()); // Phát ra trạng thái đang tải
    final result = await _signInWithGoogleUseCase();
    result.fold(
      (failure) => emit(AuthError(failure.message)), // Phát ra trạng thái lỗi
      (user) => emit(AuthSuccess(user)), // Phát ra trạng thái thành công
    );
  }

  // Hàm xử lý sự kiện đăng xuất
  Future<void> _onSignOutEvent(
    AuthSignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading()); // Phát ra trạng thái đang tải
    final result = await _signOutUseCase();
    result.fold(
      (failure) => emit(AuthError(failure.message)), // Phát ra trạng thái lỗi
      (_) => emit(const AuthSuccess(null)), // Phát ra trạng thái thành công (user null khi đăng xuất)
    );
  }

  // Hàm xử lý khi trạng thái người dùng thay đổi (ví dụ: từ Firebase Auth)
  // void _onAuthUserChangedEvent(
  //   AuthUserChangedEvent event,
  //   Emitter<AuthState> emit,
  // ) {
  //   if (event.user != null) {
  //     emit(AuthSuccess(event.user));
  //   } else {
  //     emit(const AuthSuccess(null));
  //   }
  // }
}