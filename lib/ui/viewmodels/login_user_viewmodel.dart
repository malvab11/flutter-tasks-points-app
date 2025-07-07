import 'package:flutter/material.dart';

class LoginUserViewmodel extends ChangeNotifier {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _isEnabled = false;

  TextEditingController get user => _userController;
  TextEditingController get code => _codeController;
  bool get isEnabled => _isEnabled;

  void loginButtonValidation() {
    _isEnabled =
        _userController.text.isNotEmpty && (_codeController.text.length == 6);
    notifyListeners();
  }
}
