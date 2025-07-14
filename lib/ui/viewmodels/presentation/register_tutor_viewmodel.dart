import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mission_up/core/utils/firebase_error_mapper.dart';
import 'package:mission_up/domain/entity/user_entity.dart';
import 'package:mission_up/domain/usecases/auth/register_with_email_usecase.dart';

class RegisterTutorViewModel extends ChangeNotifier {
  // Controllers
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rpasswordController = TextEditingController();

  // Use cases
  final RegisterWithEmailUseCase _registerWithEmailUsecase;

  RegisterTutorViewModel(this._registerWithEmailUsecase);

  // Estado
  String _errorMessage = "";
  String _errorService = "";
  String _message = "";
  bool _isEnabled = false;
  bool _isObscure = true;
  bool _isLoading = false;
  UserEntity? _user;

  // Getters
  TextEditingController get user => _userController;
  TextEditingController get email => _emailController;
  TextEditingController get password => _passwordController;
  TextEditingController get rpassword => _rpasswordController;
  String get errorMessage => _errorMessage;
  String get errorService => _errorService;
  String get message => _message;
  bool get isEnabled => _isEnabled;
  bool get isObscure => _isObscure;
  bool get isLoading => _isLoading;
  UserEntity? get registeredUser => _user;

  // Funciones internas
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorFirebase(Object? error) {
    _errorService = FirebaseErrorMapper.getMessage(error);
    notifyListeners();
  }

  void _setErrorValidation(String? error) {
    _errorMessage = error ?? '';
    notifyListeners();
  }

  void _setMessage(String? message) {
    _message = message ?? '';
    notifyListeners();
  }

  // Validación de campos y botón
  void registerButtonValidation() {
    _isEnabled =
        _userController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _rpasswordController.text.isNotEmpty &&
        passwordValidation();
    notifyListeners();
  }

  // Validación de contraseña con r contraseña
  bool passwordValidation() {
    if (_passwordController.text == _rpasswordController.text) {
      _setErrorValidation(null);
      return true;
    } else if (_passwordController.text.length < 6) {
      _setErrorValidation("Contraseña menor a 6 digitos");
      return false;
    } else {
      _setErrorValidation("Las contraseñas no coinciden, volver a intentar");
      return false;
    }
  }

  // Toogle de contraseña
  void passwordVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  //Función principal de registro
  Future<void> registerTutor() async {
    _setLoading(true);
    _setErrorFirebase(null);
    _setMessage(null);
    _user = null;
    try {
      final userEntity = await _registerWithEmailUsecase(
        email: _emailController.text.trim(),
        user: _userController.text.trim(),
        password: _passwordController.text.trim(),
      );
      _user = userEntity;
    } on FirebaseAuthException catch (e) {
      _setErrorFirebase(e.code);
    } catch (e) {
      _setMessage(e.toString());
    } finally {
      _setLoading(false);
      _setMessage("Usuario creado con exito");
    }
  }

  //Limpieza de los controllers
  void clearControllers() {
    _userController.clear();
    _emailController.clear();
    _passwordController.clear();
    _rpasswordController.clear();
    _errorMessage = '';
    _errorService = '';
    _isEnabled = false;
    notifyListeners();
  }
}
