import 'package:shoplyapp/core/error/fealure.dart';
import 'package:shoplyapp/core/util/either.dart';
import 'package:shoplyapp/features/domain/entities/User_entity.dart';

/// Abstract interface (contract) for authentication.
abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithEmail(
      String email, String password);
  Future<Either<Failure, UserEntity>> signUp(
      String fullName, String email, String password);
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, void>> signOut();
}