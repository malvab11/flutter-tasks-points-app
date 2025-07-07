import 'package:mission_up/domain/entity/activity_entity.dart';

final List<ActivityEntity> activitiesConstants = [
  ActivityEntity(activity: "Hacer la cama", score: 2),
  ActivityEntity(activity: "Participar en clase", score: 3),
  ActivityEntity(activity: "Limpiar el cuarto", score: 1, done: true),
];

final List<ActivityEntity> rewardsConstants = [
  ActivityEntity(activity: "Noche de Cine", score: 25),
  ActivityEntity(activity: "Comprar Legos", score: 100),
  ActivityEntity(activity: "Noche de Pizza", score: 150),
  ActivityEntity(activity: "Salida a Jugar", score: 10),
];

final List<UserEntity> userConstants = [
  UserEntity(score: 8, tasks: "2/10", user: "Marlon"),
  UserEntity(score: 0, tasks: "0/10", user: "Paolo"),
  UserEntity(score: 17, tasks: "10/10", user: "Julio"),
];
