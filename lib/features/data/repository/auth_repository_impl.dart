import 'package:shoplyapp/core/error/fealure.dart';
import 'package:shoplyapp/core/util/either.dart';
import 'package:shoplyapp/features/data/data-sources/auth_remote_datasource.dart';
import 'package:shoplyapp/features/domain/entities/User_entity.dart';
import 'package:shoplyapp/features/domain/repository/auth_repository.dart';

/// Concrete implementation of the AuthRepository interface.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail(
      String email, String password) async {
    try {
      final userModel = await remoteDataSource.signIn(email, password);
      // Success: returns the UserEntity (up-casting UserModel to Entity)
      return (right: userModel, left: null);
    } on ServerFailure catch (e) {
      // Failure: catches the error and wraps it in the Failure type
      return (left: ServerFailure(e.message), right: null);
    } catch (e) {
      return (left: ServerFailure('An unknown error occurred: $e'), right: null);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(
      String fullName, String email, String password) async {
    try {
      final userModel =
          await remoteDataSource.register(fullName, email, password);
      return (right: userModel, left: null);
    } on ServerFailure catch (e) {
      return (left: ServerFailure(e.message), right: null);
    }
  }

  // Implement other methods...
  @override
  Future<Either<Failure, void>> signOut() async {
    // Implementation of sign out
    return (right: null, left: null);
  }
  
  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final userModel = await remoteDataSource.signInGoogle();
      return (right: userModel, left: null);
    } on ServerFailure catch (e) {
      return (left: ServerFailure(e.message), right: null);
    }
  }
}