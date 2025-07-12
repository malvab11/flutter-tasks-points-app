import 'package:mission_up/domain/entity/user_entity.dart';
import 'package:mission_up/domain/repositories/auth_repository.dart';

class RegisterWithEmailUseCase {
  final AuthRepository repository;

  RegisterWithEmailUseCase(this.repository);

  Future<UserEntity> call({
    required String email,
    required String user,
    required String password,
  }) {
    return repository.registerWithEmail(
      email: email,
      user: user,
      password: password,
    );
  }
}
