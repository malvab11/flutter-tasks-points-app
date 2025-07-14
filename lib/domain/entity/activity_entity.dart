class ActivityEntity {
  final String activity;
  final int score;
  final bool? done;

  ActivityEntity({
    required this.activity,
    required this.score,
    this.done = false,
  });
}

class UserEntity2 {
  final String user;
  final int score;
  final String tasks;

  UserEntity2({required this.score, required this.tasks, required this.user});
}
