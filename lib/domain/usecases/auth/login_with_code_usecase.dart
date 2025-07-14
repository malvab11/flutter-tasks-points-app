import 'package:mission_up/domain/entity/user_entity.dart';
import 'package:mission_up/domain/repositories/auth_repository.dart';

class LoginWithCodeUsecase {
  final AuthRepository repository;

  LoginWithCodeUsecase(this.repository);

  Future<UserEntity> call({required String user, required String familyCode}) {
    return repository.loginWithCode(user: user, familyCode: familyCode);
  }
}
