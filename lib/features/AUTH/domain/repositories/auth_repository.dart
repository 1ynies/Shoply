import '../entities/user_entity.dart';

/// The Abstract Contract (Interface) for Auth functionality.
/// This allows us to easily swap Firebase for another backend later if needed.
abstract class AuthRepository {
  Stream<UserEntity?> get user;
  
  Future<UserEntity> signInWithEmail(String email, String password);
  
  Future<UserEntity> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  });
  
  Future<UserEntity> signInWithGoogle();
  
  Future<void> sendPasswordResetEmail(String email);
  
  Future<void> signOut();
}



//--THIS IS THE LAST FILE YOU EDITED
