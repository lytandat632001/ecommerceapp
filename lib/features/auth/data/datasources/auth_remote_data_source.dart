import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

// Định nghĩa một interface (abstract class) cho Remote Data Source
abstract class AuthRemoteDataSource {
  Future<UserCredential> signInWithGoogle();
  Future<void> signOut();
  Stream<User?> get authStateChanges; // Stream để lắng nghe trạng thái đăng nhập
}

// Đánh dấu lớp này là một LazySingleton và đăng ký nó là triển khai của AuthRemoteDataSource
@LazySingleton(as: AuthRemoteDataSource)
// Triển khai AuthRemoteDataSource sử dụng Firebase Auth và Google Sign-In
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  // Injectable sẽ tự động tìm các dependencies (FirebaseAuth và GoogleSignIn)
  // từ FirebaseModule thông qua constructor này.
  // KHÔNG cần @factoryMethod ở đây vì chỉ có một constructor.
  AuthRemoteDataSourceImpl({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'ABORTED_BY_USER',
          message: 'Google Sign-In was aborted by the user.',
        );
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("FirebaseAuthException in signInWithGoogle: ${e.code} - ${e.message}");
      }
      rethrow;
    } catch (e) {
      throw FirebaseAuthException(
        code: 'UNKNOWN_GOOGLE_SIGN_IN_ERROR',
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> signOut() async {
    await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}

// KHÔNG CÓ FirebaseModule Ở ĐÂY! HÃY XÓA NÓ RA KHỎI FILE NÀY.
// // Định nghĩa một module để cung cấp FirebaseAuth và GoogleSignIn
// @module
// abstract class FirebaseModule {
//   @LazySingleton()
//   FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
//
//   @LazySingleton()
//   GoogleSignIn get googleSignIn => GoogleSignIn();
// }