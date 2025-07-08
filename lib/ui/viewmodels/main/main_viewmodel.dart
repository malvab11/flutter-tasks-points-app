import 'package:flutter/material.dart';

class MainViewmodel extends ChangeNotifier {
  int _currentScreen = 0;

  int get currentScreen => _currentScreen;

  void changeScreen(int screenIndex) {
    _currentScreen = screenIndex;
    notifyListeners();
  }
}
