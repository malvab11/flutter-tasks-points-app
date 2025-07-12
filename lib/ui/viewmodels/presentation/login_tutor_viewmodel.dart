import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mission_up/core/utils/firebase_error_mapper.dart';
import 'package:mission_up/domain/entity/user_entity.dart';
import 'package:mission_up/domain/usecases/auth/login_with_email_usecase.dart';
import 'package:mission_up/domain/usecases/auth/login_with_social_usecase.dart';

class LoginTutorViewmodel extends ChangeNotifier {
  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Use Cases
  final LoginWithEmailUseCase _loginWithEmailUsecase;
  final LoginWithSocialUsecase _loginWithSocialUsecase;

  LoginTutorViewmodel(
    this._loginWithEmailUsecase,
    this._loginWithSocialUsecase,
  );

  // Estados internos
  bool _isEnabled = false;
  bool _isObscure = true;
  bool _isLoading = false;
  String _errorService = "";
  String _message = "";
  UserEntity? _user;

  // Getters
  TextEditingController get email => _emailController;
  TextEditingController get password => _passwordController;
  bool get isEnabled => _isEnabled;
  bool get isObscure => _isObscure;
  bool get isLoading => _isLoading;
  String? get errorService => _errorService;
  String? get message => _message;
  UserEntity? get user => _user;

  // Funciones internas
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorFirebase(Object? error) {
    _errorService = FirebaseErrorMapper.getMessage(error);
    notifyListeners();
  }

  void _setMessage(String? message) {
    _message = message ?? '';
    notifyListeners();
  }

  // Validación de campos
  void loginButtonValidation() {
    _isEnabled =
        _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    notifyListeners();
  }

  // Mostrar/Ocultar contraseña
  void passwordVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  // Login con Email y Contraseña
  Future<void> loginWithEmail() async {
    _setLoading(true);
    _setErrorFirebase(null);
    _setMessage(null);
    _user = null;
    try {
      _user = await _loginWithEmailUsecase(
        email: _emailController.text.trim().toLowerCase(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseException catch (e) {
      _setErrorFirebase(e.code);
    } catch (e) {
      _setErrorFirebase(e);
    } finally {
      _setLoading(false);
    }
  }

  // Login con redes sociales (Google, Facebook)
  Future<void> loginWithSocial() async {
    _user = null;
    _setLoading(true);
    _setErrorFirebase(null);
    _setMessage(null);
    try {
      _user = await _loginWithSocialUsecase.call();
      if (_user == null) {
        _setMessage('Inicio de sesión cancelado por el usuario.');
      }
    } on FirebaseException catch (e) {
      _setErrorFirebase(e.code);
    } catch (e) {
      _setErrorFirebase(e);
    } finally {
      _setLoading(false);
    }
  }

  //Limpieza de controllers
  void clearControllers() {
    _emailController.clear();
    _passwordController.clear();
    _errorService = '';
    _message = '';
    _isEnabled = false;
    notifyListeners();
  }
}
