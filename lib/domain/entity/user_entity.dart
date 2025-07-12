class UserEntity {
  final String id;
  final String email;
  final String user;
  final String rol; //rol del usuario Tutor o Estudiante
  final String familyCode;

  UserEntity({
    required this.id,
    required this.email,
    required this.user,
    required this.rol,
    required this.familyCode,
  });
}
