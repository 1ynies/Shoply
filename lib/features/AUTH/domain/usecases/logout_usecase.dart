import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

// 1. Sign In UseCase
class SignInWithEmailUseCase {
  final AuthRepository repository;
  SignInWithEmailUseCase(this.repository);

  Future<UserEntity> call(String email, String password) {
    return repository.signInWithEmail(email, password);
  }
}

// 2. Sign Up UseCase
class SignUpWithEmailUseCase {
  final AuthRepository repository;
  SignUpWithEmailUseCase(this.repository);

  Future<UserEntity> call({required String fullName, required String email, required String password}) {
    return repository.signUpWithEmail(fullName: fullName, email: email, password: password);
  }
}

// 3. Google Sign In UseCase
class SignInWithGoogleUseCase {
  final AuthRepository repository;
  SignInWithGoogleUseCase(this.repository);

  Future<UserEntity> call() {
    return repository.signInWithGoogle();
  }
}

// 4. Reset Password UseCase
class ResetPasswordUseCase {
  final AuthRepository repository;
  ResetPasswordUseCase(this.repository);

  Future<void> call(String email) {
    return repository.sendPasswordResetEmail(email);
  }
}

// 5. Sign Out UseCase
class SignOutUseCase {
  final AuthRepository repository;
  SignOutUseCase(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}

// 6. Auth Status Stream UseCase (Optional, can be used in Bloc)
class GetAuthStatusUseCase {
  final AuthRepository repository;
  GetAuthStatusUseCase(this.repository);

  Stream<UserEntity?> call() {
    return repository.user;
  }
}