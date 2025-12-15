import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
import '../../../../core/error/exceptions.dart';

// THIS CLASS DO DIRECT FIREBASE CALLS

// abstarct class
abstract class AuthRemoteDataSource {
  Stream<UserModel?> get user;
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String fullName, String email, String password);
  Future<UserModel> googleLogin();
  Future<void> resetPassword(String email);
  Future<void> logout();
}

// the abstract class implemented here
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl(this._firebaseAuth, this._googleSignIn);

  @override
  Stream<UserModel?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) return null;
      return UserModel.fromFirebaseUser(firebaseUser);
    });
  }

  // == ACTUAL LOGIN METHOD ==
  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw ServerException("Please check your internet connection.");
      } else if (e.code == 'user-not-found') {
        throw ServerException("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        throw ServerException("Wrong password provided.");
      } else {
        throw ServerException(e.message ?? "Authentication failed");
      }
    }
  }

  // == ACTUAL REGISTER METHOD ==
  @override
  Future<UserModel> register(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Immediately update display name so it appears in the app
      await credential.user!.updateDisplayName(fullName);
      await credential.user!.reload(); // Reload to apply changes
      final updatedUser = _firebaseAuth.currentUser;
      return UserModel.fromFirebaseUser(updatedUser!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? "Registration failed");
    }
  }

  // == ACTUAL GOOGLE LOGIN METHOD ==
  @override
  Future<UserModel> googleLogin() async {
    try {
      // Ensure initialized
      await _googleSignIn.initialize();
      // === ATTEMPT LOGIN === 
      final GoogleSignInAccount? googleUser = await _googleSignIn
          .authenticate();

      if (googleUser == null) throw ServerException("Google Sign-In Aborted");
      //  === CONTINUE WITH AUTH IF USER EXISTS ===
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: null,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // == ACTUAL RESET PASSWORD METHOD ==
  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? "Reset password failed");
    }
  }

  // == ACTUAL LOGOUT METHOD ==
  @override
  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
