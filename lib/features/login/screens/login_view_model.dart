import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isShown = false;
  bool get isShown => _isShown;

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  void onIconTap() {
    _isShown = !_isShown;
    notifyListeners();
  }

  void back(BuildContext context) {
    Navigator.pushNamed(context, 'presentation');
  }

  bool formValidation() {
    final email = emailController.text;
    final password = passwordController.text;
    return email.isNotEmpty && password.isNotEmpty;
  }

  void onLoginPressed(BuildContext context) {
    if (formValidation()) {
      //Navigator.pushNamed(context, 'loading');
      print(
        'Se esta enviando ${emailController.text} y ${passwordController.text}',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
    }
  }

  void onRegisterPressed(BuildContext context) {
    Navigator.pushNamed(context, 'registerTutor');
  }
}
