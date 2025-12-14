import 'package:shoplyapp/features/AUTH/domain/entities/user_entity.dart';
import 'package:shoplyapp/features/AUTH/domain/repositories/auth_repository.dart';

class SignInWithEmailUseCase {
  final AuthRepository repository;
  SignInWithEmailUseCase(this.repository);

  Future<UserEntity> call(String email, String password) {
    return repository.signInWithEmail(email, password);
  }
}