import 'package:mission_up/domain/repositories/auth_repository.dart';

class LogOutUseCase {
  final AuthRepository repository;

  LogOutUseCase(this.repository);

  Future<void> call() {
    return repository.logOut();
  }
}
