class LoadingUsecase {
  Future<bool> validarUsuario() async {
    await Future.delayed(Duration(seconds: 3));
    return false;
  }
}
