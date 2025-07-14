import 'package:mission_up/data/models/user_model.dart';

abstract class AuthDatasource {
  //Funciones de registro con correo.
  Future<UserModel> registerWithEmail({
    required String email,
    required String user, //Datos como nombres y apellidos del usuario
    required String password,
  });
  //Funcion de login con el correo
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  });
  //Funcion de login con el codigo de invitacion
  Future<UserModel> loginWithCode({
    required String user,
    required String familyCode,
  });
  //Funcion de login con autenticación de Google
  Future<UserModel?> loginWithGoogle();
  //Funcion de obtención del usuario
  Future<UserModel> getCurrentUser();
  //Funcion de logout
  Future<void> logOut();
}
