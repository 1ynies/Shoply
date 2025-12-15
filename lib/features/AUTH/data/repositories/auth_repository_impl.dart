import 'package:shoplyapp/features/AUTH/data/datasources/auth_local_data_source.dart.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

// THIS CLASS IMPLEMENTS THE AUTHREPOSITORY ABSTRACT CLASS SITUATED IN THE DOMAIN -> REPOSITORIES -> AUTH_REPOSITORY.DART
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Stream<UserEntity?> get user => remoteDataSource.user;

  // ==== LOG IN WITH EMAIL FUNCTION ====
  @override
  Future<UserEntity> signInWithEmail({
    required String email,
    required String password,
  }) async {
    // 1. Perform the Remote Login
    final user = await remoteDataSource.login(email, password);

    return user;
  }

  // ==== REGISTER WITH EMAIL FUNCTION ====
  // Removed 'rememberMe' to match the fixed Interface
  @override
  Future<UserEntity> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  }) async {
    // 1. Register
    final user = await remoteDataSource.register(fullName, email, password);

    return user;
  }

  // ==== LOG IN WITH GOOGLE FUNCTION ====
  @override
  Future<UserEntity> signInWithGoogle() async {
    return await remoteDataSource.googleLogin();
  }

  // ==== FORGOT PASSWORD FUNCTION ====
  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await remoteDataSource.resetPassword(email);
  }

  // ==== LOG OUT FUNCTION ====
  @override
  Future<void> signOut() async {
    await remoteDataSource.logout(); // Sign out from Firebase
    await localDataSource.clearCache(); // Clear the "Remember Me" token
  }

  @override
  Future<bool> isLoggedIn() async {
    return await localDataSource.isUserLoggedIn();
  }
}
