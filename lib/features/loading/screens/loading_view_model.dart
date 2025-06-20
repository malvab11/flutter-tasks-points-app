import 'package:flutter/material.dart';
import 'package:mission_up/features/loading/domain/loading_usecase.dart';

class LoadingViewModel extends ChangeNotifier {
  final LoadingUsecase _loadingUseCase;

  LoadingViewModel(this._loadingUseCase);

  Future<bool> startLoading() async {
    await Future.delayed(const Duration(seconds: 1));
    return await _loadingUseCase.validarUsuario();
  }
}
