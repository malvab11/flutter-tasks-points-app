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
  final LoginWithEmailUsecase _loginWithEmailUsecase;
  final LoginWithSocialUsecase _loginWithSocialUsecase;

  LoginTutorViewmodel(
    this._loginWithEmailUsecase,
    this._loginWithSocialUsecase,
  );

  // Estados internos
  bool _isEnabled = false;
  bool _isObscure = true;
  bool _isLoading = false;
  String? _errorMessage;
  String? _errorService;
  UserEntity? _user;

  // Getters
  TextEditingController get email => _emailController;
  TextEditingController get password => _passwordController;
  bool get isEnabled => _isEnabled;
  bool get isObscure => _isObscure;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get errorService => _errorService;
  UserEntity? get user => _user;

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
    _setError(null);
    try {
      _user = await _loginWithEmailUsecase(
        email: _emailController.text.trim().toLowerCase(),
        password: _passwordController.text.trim(),
      );
    } catch (e) {
      _setError(FirebaseErrorMapper.getMessage(e));
    } finally {
      _setLoading(false);
    }
  }

  // Login con redes sociales (Google, Facebook)
  Future<void> loginWithSocial() async {
    _setLoading(true);
    _setError(null);
    try {
      _user = await _loginWithSocialUsecase('tutor');
      if (_user == null) {
        _setErrorService('Inicio de sesión cancelado por el usuario.');
      }
    } catch (e) {
      _setError(FirebaseErrorMapper.getMessage(e));
    } finally {
      _setLoading(false);
    }
  }

  // Internos
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _setErrorService(String? message) {
    _errorService = message;
    notifyListeners();
  }

  void clearControllers() {
    _emailController.clear();
    _passwordController.clear();
    _errorMessage = null;
    _isEnabled = false;
    notifyListeners();
  }
}
