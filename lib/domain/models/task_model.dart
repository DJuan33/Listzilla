import 'dart:core';
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int index;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final bool completed;

  @HiveField(4)
  final bool priority;

  @HiveField(5)
  final String description;

  @HiveField(6)
  final DateTime creationDate;

  @HiveField(7)
  final DateTime expirationDate;

  @HiveField(8)
  final DateTime pomodoro;

  @HiveField(9)
  final bool myDay;

  Task(
      {required this.id,
      required this.index,
      required this.name,
      required this.completed,
      required this.priority,
      required this.description,
      required this.creationDate,
      required this.expirationDate,
      required this.pomodoro,
      required this.myDay,
      });
}
