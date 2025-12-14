import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';

///  === Extends the Entity to include logic for converting from Firebase User. ===
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    super.imagePath,
    super.createdAt,
    super.lastLogin,
    required super.authType,
  });

  
  factory UserModel.fromFirebaseUser(User user) {
    // Determine Auth Type based on provider data
    String type = 'unknown';
    if (user.providerData.isNotEmpty) {
      if (user.providerData.any((info) => info.providerId == 'google.com')) {
        type = 'google';
      } else if (user.providerData.any((info) => info.providerId == 'password')) {
        type = 'email';
      }
    }

    return UserModel(
      id: user.uid,
      fullName: user.displayName ?? '',
      email: user.email ?? '',
      imagePath: user.photoURL,
      createdAt: user.metadata.creationTime,
      lastLogin: user.metadata.lastSignInTime,
      authType: type,
    );
  }
}