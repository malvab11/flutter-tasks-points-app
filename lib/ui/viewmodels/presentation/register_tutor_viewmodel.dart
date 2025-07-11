import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mission_up/core/utils/firebase_error_mapper.dart';
import 'package:mission_up/domain/entity/user_entity.dart';
import 'package:mission_up/domain/usecases/auth/generate_family_code_usecase.dart';
import 'package:mission_up/domain/usecases/auth/register_with_email_usecase.dart';
import 'package:mission_up/domain/usecases/auth/save_family_code_usecase.dart';

class RegisterTutorViewModel extends ChangeNotifier {
  // Controllers
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rpasswordController = TextEditingController();

  // Use cases
  final RegisterWithEmailUseCase _registerWithEmailUsecase;
  final GenerateFamilyCodeUsecase _generateCodeUsecase;
  final SaveFamilyCodeUsecase _saveFamilyCodeUsecase;

  RegisterTutorViewModel(
    this._registerWithEmailUsecase,
    this._generateCodeUsecase,
    this._saveFamilyCodeUsecase,
  );

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

  void _setErrorFromException(Object? error) {
    _errorService = FirebaseErrorMapper.getMessage(error);
    notifyListeners();
  }

  void _setErrorMessage(String? error) {
    _errorMessage = error ?? '';
    notifyListeners();
  }

  void _setMessage(String message) {
    _errorMessage = message;
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

  bool passwordValidation() {
    if (_passwordController.text == _rpasswordController.text) {
      _setErrorMessage(null);
      return true;
    } else {
      _setErrorMessage("Las contraseñas no coinciden, volver a intentar");
      return false;
    }
  }

  void passwordVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  //Función principal de registro
  Future<void> registerTutor() async {
    _setLoading(true);
    _setErrorFromException(null);

    try {
      // 1. Registrar el tutor
      final userEntity = await _registerWithEmailUsecase(
        email: _emailController.text.trim(),
        user: _userController.text.trim(),
        password: _passwordController.text.trim(),
        rol: 'tutor',
      );

      // 2. Generar código de invitación (6 dígitos aleatorios)
      final code = await _generateCodeUsecase();

      // 3. Guardar el código en la colección 'familys'
      await _saveFamilyCodeUsecase(code: code, uidTutor: userEntity.uid);

      _user = userEntity;
    } on FirebaseAuthException catch (e) {
      _setErrorFromException(e.code);
      _user = null;
    } catch (e) {
      _setErrorFromException(e.toString());
      _user = null;
    } finally {
      _setLoading(false);
    }
  }

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
