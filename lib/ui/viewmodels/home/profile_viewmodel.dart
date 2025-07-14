import 'package:flutter/material.dart';
import 'package:mission_up/core/errors/AuthExceptions.dart';
import 'package:mission_up/domain/usecases/auth/logout_usecase.dart';

class ProfileViewModel extends ChangeNotifier {
  //Use Cases
  final LogOutUseCase _logOutUseCase;

  ProfileViewModel(this._logOutUseCase);

  //Variables internas
  bool _isLoading = false;
  String? _message = null;

  //Getters
  bool get isLoading => _isLoading;
  String? get message => _message;

  //Funciones internas
  _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  _setMessage(String? message) {
    _message = message;
    notifyListeners();
  }

  //Funcion LogOut
  Future<void> logOut() async {
    _setLoading(true);
    _setMessage(null);
    try {
      await _logOutUseCase();
    } on AuthException catch (e) {
      _setMessage(e.message);
    } catch (e) {
      _setMessage(e.toString());
    } finally {
      _setLoading(false);
    }
  }
}
