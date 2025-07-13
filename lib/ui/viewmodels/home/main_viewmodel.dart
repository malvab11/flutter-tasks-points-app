import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mission_up/data/models/user_model.dart';
import 'package:mission_up/domain/entity/user_entity.dart';
import 'package:mission_up/domain/usecases/auth/get_current_user_usecase.dart';

class MainViewmodel extends ChangeNotifier {
  GetCurrentUserUseCase _getCurrentUserUseCase;

  MainViewmodel(this._getCurrentUserUseCase);

  int _currentScreen = 0;
  UserEntity? _user;

  int get currentScreen => _currentScreen;
  UserEntity? get user => _user;

  void changeScreen(int screenIndex) {
    _currentScreen = screenIndex;
    notifyListeners();
  }

  Future<void> getCurrentUser() async {
    _user = await _getCurrentUserUseCase();
    notifyListeners();
  }
}
