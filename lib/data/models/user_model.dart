import 'package:mission_up/domain/entity/activity_entity.dart';
import 'package:mission_up/domain/entity/user_entity.dart';

class UserModel {
  final String uid;
  final String email;
  final String? user;
  final String? photoUrl;
  final String rol; //rol del usuario Tutor o Estudiante

  UserModel({
    required this.uid,
    required this.email,
    this.user,
    this.photoUrl,
    required this.rol,
  });

  //De firebase a model
  factory UserModel.fromJson(Map<String, dynamic> firebase, String userId) {
    return UserModel(
      uid: userId,
      email: firebase['email'] ?? '',
      user: firebase['user'],
      photoUrl: firebase['photoUrl'],
      rol: firebase['rol'] ?? 'user',
    );
  }

  //De model a firebase
  Map<String, dynamic> toJson() {
    return {'user': user, 'email': email, 'rol': rol, 'photoUrl': photoUrl};
  }

  //De model a entity
  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      email: email,
      user: user,
      rol: rol,
      photoUrl: photoUrl,
    );
  }

  //De entity a model
  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      uid: userEntity.uid,
      user: userEntity.user,
      email: userEntity.email,
      rol: userEntity.rol,
      photoUrl: userEntity.photoUrl,
    );
  }
}
