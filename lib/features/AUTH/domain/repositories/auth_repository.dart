import '../entities/user_entity.dart';

/// The Abstract Contract (Interface) for Auth functionality.
/// This allows us to easily swap Firebase for another backend later if needed.
abstract class AuthRepository {
  Stream<UserEntity?> get user;
  
  // absract login with email function 
  Future<UserEntity> signInWithEmail(String email, String password);
  
  // abstract register with email function
  Future<UserEntity> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  });
  
  // abstract sign in with google function
  Future<UserEntity> signInWithGoogle();
  
  // abstract send password reset email function
  Future<void> sendPasswordResetEmail(String email);
  
  //abstract sign out function
  Future<void> signOut();
}




