import 'package:flutter/material.dart';

class RegisterUserViewModel extends ChangeNotifier {
  final userDataController = TextEditingController();
  final codeController = TextEditingController();

  void disposeControllers() {
    userDataController.dispose();
    codeController.dispose();
  }

  void back(BuildContext context) {
    Navigator.pop(context);
  }

  bool formValidation() {
    final userData = userDataController.text;
    final code = codeController.text;
    return userData.isNotEmpty && code.isNotEmpty;
  }

  void onRegisterPressed(BuildContext context) {
    if (formValidation()) {
      //Navigator.pushNamed(context, 'loading');
      debugPrint(
        'Se esta enviando ${userDataController.text} y ${codeController.text}',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
    }
  }
}
