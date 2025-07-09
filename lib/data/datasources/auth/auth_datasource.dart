import 'package:mission_up/data/models/user_model.dart';

abstract class AuthDatasource {
  //Funciones de registro
  Future<UserModel> registerWithEmail({
    required String email,
    required String user,
    required String password,
    required String rol,
  });
  //Funcion de login con el correo
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  });
  //Funcion de login con el codigo de invitacion
  Future<UserModel> loginWithCode({required String user, required String code});
  //Funcion de login con autenticación de Google
  Future<UserModel?> loginWithGoogle({required String rol});
  //Funcion de obtención del usuario
  Future<UserModel?> getCurrentUser();
  //Funcion de logout
  Future<void> logOut();
}
