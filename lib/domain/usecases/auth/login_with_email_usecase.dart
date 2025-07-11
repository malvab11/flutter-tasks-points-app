import 'package:mission_up/domain/entity/user_entity.dart';
import 'package:mission_up/domain/repositories/auth_repository.dart';

class LoginWithEmailUsecase {
  final AuthRepository repository;

  LoginWithEmailUsecase(this.repository);

  Future<UserEntity> call({required String email, required String password}) {
    return repository.loginWithEmail(email: email, password: password);
  }
}
