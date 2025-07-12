import 'package:mission_up/domain/entity/user_entity.dart';

class UserModel {
  final String id; //uid que devuelve firebase
  final String email;
  final String user;
  final String rol; // 'tutor' o 'user'
  final String familyCode; // Código de invitación si aplica

  UserModel({
    required this.id,
    required this.email,
    required this.user,
    required this.rol,
    required this.familyCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String userId) {
    return UserModel(
      id: userId,
      email: json['email'] ?? '',
      user: json['user'],
      rol: json['rol'] ?? 'user',
      familyCode: json['familyCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': user, 'email': email, 'rol': rol, 'familyCode': familyCode};
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      user: user,
      rol: rol,
      familyCode: familyCode,
    );
  }

  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      id: userEntity.id,
      user: userEntity.user,
      email: userEntity.email,
      rol: userEntity.rol,
      familyCode: userEntity.familyCode,
    );
  }
}
