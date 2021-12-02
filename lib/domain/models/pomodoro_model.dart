import 'dart:core';
import 'package:hive/hive.dart';

part 'pomodoro_model.g.dart';

@HiveType(typeId: 4)
class Pomodoro {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime dateCompleted;

  @HiveField(2)
  final int lengthInSeconds;

  @HiveField(3)
  final String taskID;

  Pomodoro({
      required this.id,
      required this.dateCompleted,
      required this.lengthInSeconds,
      required this.taskID
  });
}
