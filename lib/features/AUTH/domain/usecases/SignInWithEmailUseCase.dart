import 'package:shoplyapp/features/AUTH/domain/entities/user_entity.dart';
import 'package:shoplyapp/features/AUTH/domain/repositories/auth_repository.dart';

class SignInWithEmailUseCase {
  final AuthRepository repository;
  SignInWithEmailUseCase(this.repository);

  // UPDATE: Add named parameter 'rememberMe'
  Future<UserEntity> call({
    required String email,
    required String password,
    
  }) {
    return repository.signInWithEmail(
      email: email,
      password: password,
      
    );
  }
}
