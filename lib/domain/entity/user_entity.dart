class UserEntity {
  final String uid;
  final String email;
  final String? user;
  final String? photoUrl; //foto del usuario y tutor, aplicación más adelante
  final String rol; //rol del usuario Tutor o Estudiante

  UserEntity({
    required this.uid,
    required this.email,
    this.user,
    this.photoUrl,
    required this.rol,
  });
}
