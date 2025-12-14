import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<UserEntity?> get user => remoteDataSource.user;

  @override
  Future<UserEntity> signInWithEmail(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<UserEntity> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.register(fullName, email, password);
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    return await remoteDataSource.googleLogin();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await remoteDataSource.resetPassword(email);
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.logout();
  }
}