import 'package:shoplyapp/features/AUTH/domain/entities/user_entity.dart';
import 'package:shoplyapp/features/AUTH/domain/repositories/auth_repository.dart';

class SignUpWithEmailUseCase {
  final AuthRepository repository;
  SignUpWithEmailUseCase(this.repository);

  Future<UserEntity> call({required String fullName, required String email, required String password}) {
    return repository.signUpWithEmail(fullName: fullName, email: email, password: password);
  }
}