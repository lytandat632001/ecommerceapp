import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Định nghĩa một interface (abstract class) cho Remote Data Source
// Điều này giúp dễ dàng thay đổi hoặc thêm các nguồn dữ liệu xác thực khác trong tương lai
abstract class AuthRemoteDataSource {
  Future<UserCredential> signInWithGoogle();
  Future<void> signOut();
  Stream<User?> get authStateChanges; // Stream để lắng nghe trạng thái đăng nhập
}

// Triển khai AuthRemoteDataSource sử dụng Firebase Auth và Google Sign-In
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource { // Sử dụng Firebase Auth và Google Sign-In
  // Các trường để lưu trữ các instance của FirebaseAuth và GoogleSignIn
  final FirebaseAuth _firebaseAuth; // Firebase Auth instance để thực hiện các thao tác xác thực
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl({ // Khởi tạo AuthRemoteDataSourceImpl với các instance của FirebaseAuth và GoogleSignIn
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance, // Nếu không truyền vào, sử dụng instance mặc định của FirebaseAuth
       _googleSignIn = googleSignIn ?? GoogleSignIn(); // Nếu không truyền vào, sử dụng instance mặc định của GoogleSignIn

  @override
  Future<UserCredential> signInWithGoogle() async { // Phương thức để đăng nhập với Google
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn(); // Yêu cầu người dùng đăng nhập với Google
      if (googleUser == null) { // Nếu người dùng hủy đăng nhập, trả về ngoại lệ
   
        throw FirebaseAuthException(
          code: 'ABORTED_BY_USER',
          message: 'Google Sign-In was aborted by the user.',
        );
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication; // Lấy thông tin xác thực từ Google Sign-In
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // Ném lại các ngoại lệ Firebase Auth
      rethrow;
    } catch (e) {
      // Chuyển đổi các ngoại lệ khác thành ngoại lệ Firebase Auth hoặc ngoại lệ tùy chỉnh nếu cần
      throw FirebaseAuthException(
        code: 'UNKNOWN_GOOGLE_SIGN_IN_ERROR',
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}