import 'package:flutter/material.dart';

class RegisterTutorViewModel extends ChangeNotifier {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rpasswordController = TextEditingController();
  String _errorMessage = "";
  bool _isEnabled = false;
  bool _isObscure = true;

  TextEditingController get user => _userController;
  TextEditingController get email => _emailController;
  TextEditingController get password => _passwordController;
  TextEditingController get rpassword => _rpasswordController;
  String get errorMessage => _errorMessage;
  bool get isEnabled => _isEnabled;
  bool get isObscure => _isObscure;

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
      _errorMessage = "";
      return true;
    } else {
      _errorMessage = "Las contraseñas no coinciden, volver a intentar";
      return false;
    }
  }

  void passwordVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }
}
