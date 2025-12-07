import 'package:shoplyapp/config/enums.dart';
import 'package:shoplyapp/core/error/fealure.dart';
import 'package:shoplyapp/features/data/models/user_model.dart';

/// Abstract class representing the remote data source (Firebase Auth/Firestore).
abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> register(String fullName, String email, String password);
  Future<UserModel> signInGoogle();
  // ... other methods
}

/// Concrete implementation simulating Firebase/Firestore calls.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // final FirebaseFirestore firestore;
  // final FirebaseAuth auth;

  // AuthRemoteDataSourceImpl(this.firestore, this.auth);

  @override
  Future<UserModel> signIn(String email, String password) async {
    // Simulated Firestore/Auth call
    if (email == 'test@app.com' && password == 'password') {
      return UserModel(
        userID: 'auth123',
        fullName: 'Test User',
        email: email,
        passwordHash: 'hashed',
        authType: AuthType.emailPassword,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );
    } else {
      throw const ServerFailure('Invalid credentials.');
    }
  }

  @override
  Future<UserModel> register(
      String fullName, String email, String password) async {
    // Simulated registration logic
    return UserModel(
      userID: 'new-user-${DateTime.now().microsecondsSinceEpoch}',
      fullName: fullName,
      email: email,
      passwordHash: 'new-hashed',
      authType: AuthType.emailPassword,
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
    );
  }

  @override
  Future<UserModel> signInGoogle() async {
    // Simulated Google sign-in
    return UserModel(
      userID: 'google-user-123',
      fullName: 'Google Account',
      email: 'google@user.com',
      passwordHash: 'N/A',
      authType: AuthType.google,
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
    );
  }
}