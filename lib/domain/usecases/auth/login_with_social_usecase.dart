import 'package:mission_up/domain/entity/user_entity.dart';
import 'package:mission_up/domain/repositories/auth_repository.dart';

class LoginWithSocialUsecase {
  final AuthRepository repository;

  LoginWithSocialUsecase(this.repository);

  Future<UserEntity?> call() {
    return repository.loginWithGoogle();
  }

  // Future<UserEntity?> callFacebook() {
  //   return repository.loginWithFacebook();
  // }
}
