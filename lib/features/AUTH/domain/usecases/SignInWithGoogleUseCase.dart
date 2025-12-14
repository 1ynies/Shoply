import 'package:shoplyapp/features/AUTH/domain/entities/user_entity.dart';
import 'package:shoplyapp/features/AUTH/domain/repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository repository;
  SignInWithGoogleUseCase(this.repository);

  Future<UserEntity> call() {
    return repository.signInWithGoogle();
  }
}