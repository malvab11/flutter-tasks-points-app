import 'package:flutter/material.dart';

class LoginTutorViewmodel extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isEnabled = false;
  bool _isObscure = true;

  TextEditingController get email => _emailController;
  TextEditingController get password => _passwordController;
  bool get isEnabled => _isEnabled;
  bool get isObscure => _isObscure;

  void loginButtonValidation() {
    _isEnabled =
        _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    notifyListeners();
  }

  void passwordVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }
}
