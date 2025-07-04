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
