import 'package:mission_up/domain/entity/user_entity.dart';

abstract class AuthRepository {
  //Funciones de registro
  Future<UserEntity> registerWithEmail({
    required String email,
    required String user,
    required String password,
  });
  //Funcion de login con el correo
  Future<UserEntity> loginWithEmail({
    required String email,
    required String password,
  });
  //Funcion de login con el codigo de invitacion
  Future<UserEntity> loginWithCode({
    required String user,
    required String familyCode,
  });
  //Funcion de login con autenticación de Google
  Future<UserEntity?> loginWithGoogle();
  //Funcion de obtención del usuario
  Future<UserEntity?> getCurrentUser();
  //Funcion de logout
  Future<void> logOut();
}
