class FirebaseErrorMapper {
  static String getMessage(Object? error) {
    final msg = error.toString();

    if (msg.contains('user-not-found')) return 'Correo no registrado.';
    if (msg.contains('wrong-password')) return 'Contraseña incorrecta.';
    if (msg.contains('email-already-in-use'))
      return 'El correo ya está en uso.';
    if (msg.contains('invalid-email'))
      return 'El correo ingresado no es válido.';
    if (msg.contains('weak-password')) return 'La contraseña es muy débil.';
    if (msg.contains('network-request-failed'))
      return 'Sin conexión a Internet.';
    if (msg.contains('too-many-requests'))
      return 'Demasiados intentos. Intenta más tarde.';

    return 'Ocurrió un error inesperado.';
  }
}
