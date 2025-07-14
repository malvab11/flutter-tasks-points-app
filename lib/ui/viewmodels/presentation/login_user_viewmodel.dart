import 'package:flutter/material.dart';
import 'package:mission_up/core/errors/AuthExceptions.dart';
import 'package:mission_up/domain/entity/user_entity.dart';
import 'package:mission_up/domain/usecases/auth/login_with_code_usecase.dart';

class LoginUserViewmodel extends ChangeNotifier {
  // Controllers
  final TextEditingController _userDataController = TextEditingController();
  final TextEditingController _familyCodeController = TextEditingController();

  //Use Cases
  final LoginWithCodeUsecase _loginWithCodeUsecase;

  LoginUserViewmodel(this._loginWithCodeUsecase);

  // Estados internos
  bool _isEnabled = false;
  bool _isLoading = false;
  String _errorService = "";
  String _message = "";
  UserEntity? _user;

  // Getters
  TextEditingController get userData => _userDataController;
  TextEditingController get familyCode => _familyCodeController;
  bool get isEnabled => _isEnabled;
  bool get isLoading => _isLoading;
  String? get errorService => _errorService;
  String? get message => _message;
  UserEntity? get user => _user;

  // Funciones internas
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorService = error ?? '';
    notifyListeners();
  }

  void _setMessage(String? message) {
    _message = message ?? '';
    notifyListeners();
  }

  void loginButtonValidation() {
    _isEnabled =
        _userDataController.text.isNotEmpty &&
        (_familyCodeController.text.length == 6);
    notifyListeners();
  }

  // Login con Codigo de Familia
  Future<void> loginWithCode() async {
    _setLoading(true);
    _setError(null);
    _setMessage(null);
    _user = null;
    try {
      _user = await _loginWithCodeUsecase(
        user: userData.text.trim(),
        familyCode: _familyCodeController.text.trim(),
      );
      _setMessage('¡Bienvenido ${_user?.user ?? ''}!');
    } on AuthException catch (e) {
      _setError(e.message);
    } catch (e) {
      _setError('Error inesperado: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  //Clear Controllers
  void clearControllers() {
    _userDataController.clear();
    _familyCodeController.clear();
  }
}
