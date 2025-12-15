
import '../repositories/auth_repository.dart';

import '../entities/user_entity.dart';
class GetAuthStatusUseCase {
  final AuthRepository repository;

  GetAuthStatusUseCase(this.repository);

  Stream<UserEntity?> call() {
    return repository.user; 
  }
}


