import 'package:mission_up/data/datasources/auth/auth_datasource.dart';
import 'package:mission_up/domain/entity/user_entity.dart';
import 'package:mission_up/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<UserEntity> getCurrentUser() async {
    final model = await datasource.getCurrentUser();
    return model.toEntity();
  }

  @override
  Future<void> logOut() => datasource.logOut();

  @override
  Future<UserEntity> loginWithCode({
    required String user,
    required String familyCode,
  }) async {
    final model = await datasource.loginWithCode(
      user: user,
      familyCode: familyCode,
    );
    return model.toEntity();
  }

  @override
  Future<UserEntity> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final model = await datasource.loginWithEmail(
      email: email,
      password: password,
    );
    return model.toEntity();
  }

  @override
  Future<UserEntity?> loginWithGoogle() async {
    final model = await datasource.loginWithGoogle();
    return model!.toEntity();
  }

  @override
  Future<UserEntity> registerWithEmail({
    required String email,
    required String user,
    required String password,
  }) async {
    final model = await datasource.registerWithEmail(
      email: email,
      user: user,
      password: password,
    );
    return model.toEntity();
  }
}
