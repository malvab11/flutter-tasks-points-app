import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mission_up/data/models/user_model.dart';
import 'package:mission_up/domain/entity/user_entity.dart';

class MainViewmodel extends ChangeNotifier {
  int _currentScreen = 0;
  UserEntity? _user;

  int get currentScreen => _currentScreen;
  UserEntity? get user => _user;

  void changeScreen(int screenIndex) {
    _currentScreen = screenIndex;
    notifyListeners();
  }

  Future<void> loadUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      final currentUser =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.uid)
              .get();
      final data = currentUser.data();
      debugPrint(data.toString());
      if (data != null) {
        _user = UserModel.fromJson(data, currentUser.id).toEntity();
        notifyListeners();
      }
    }
  }
}
