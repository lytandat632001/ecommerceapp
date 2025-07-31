import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Cần thêm package equatable

// Để đơn giản, AuthEntity có thể ánh xạ trực tiếp từ User của Firebase Auth
class AuthEntity extends Equatable {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;

  const AuthEntity({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
  });

  // Constructor factory để tạo AuthEntity từ Firebase User
  factory AuthEntity.fromFirebaseUser( User user) { 
    return AuthEntity(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }

  @override
  List<Object?> get props => [uid, email, displayName, photoURL]; // Sử dụng Equatable để so sánh các thuộc tính của AuthEntity
}