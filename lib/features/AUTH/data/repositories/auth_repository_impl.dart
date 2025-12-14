import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';


// THIS CLASS IMPLEMENTS THE AUTHREPOSITORY ABSTRACT CLASS SITUATED IN THE DOMAIN -> REPOSITORIES -> AUTH_REPOSITORY.DART 
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<UserEntity?> get user => remoteDataSource.user;
   // ==== LOG IN WITH EMAIL FUNCTION IMPLEMENTED HERE (ABSTARCT FUNCTION IS IN DOMAIN -> REPOSITORIES-> AUTH_REPOSITORY.DART) ====
  @override
  Future<UserEntity> signInWithEmail(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }
  // === REGISTER WITH EMAIL FUNCTION IMPLEMENTED HERE (ABSTARCT FUNCTION IS IN DOMAIN -> REPOSITORIES-> AUTH_REPOSITORY.DART) ====
  @override
  Future<UserEntity> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.register(fullName, email, password);
  }
  // ==== LOG IN WITH GOOGLE FUNCTION IMPLEMENTED HERE (ABSTARCT FUNCTION IS IN DOMAIN -> REPOSITORIES-> AUTH_REPOSITORY.DART)====
  @override
  Future<UserEntity> signInWithGoogle() async {
    return await remoteDataSource.googleLogin();
  }
  // ==== FORGOT PASSWORD FUNCTION IMPLEMENTED HERE (ABSTARCT FUNCTION IS IN DOMAIN -> REPOSITORIES-> AUTH_REPOSITORY.DART) ====
  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await remoteDataSource.resetPassword(email);
  }
  // ==== LOG OUT FUNCTION IMPLEMENTED HERE (ABSTARCT FUNCTION IS IN DOMAIN -> REPOSITORIES-> AUTH_REPOSITORY.DART) ====
  @override
  Future<void> signOut() async {
    await remoteDataSource.logout();
  }
}