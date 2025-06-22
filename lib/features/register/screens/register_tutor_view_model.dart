import 'package:flutter/material.dart';

class RegisterTutorViewModel extends ChangeNotifier {
  final userDataController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rpasswordController = TextEditingController();
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
    Navigator.pushNamed(context, 'login');
  }

  bool formValidation() {
    final userData = userDataController.text;
    final email = emailController.text;
    return userData.isNotEmpty && email.isNotEmpty && passwordValidation();
  }

  bool passwordValidation() {
    final password = passwordController.text;
    final rpassword = rpasswordController.text;
    return password == rpassword;
  }

  void onRegisterPressed(BuildContext context) {
    final userData = userDataController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final rpassword = rpasswordController.text;

    if (userData.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        rpassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    if (!passwordValidation()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    Navigator.pushNamed(context, 'login');
    debugPrint('Se está enviando $userData, $email, $password, $rpassword');
  }
}
