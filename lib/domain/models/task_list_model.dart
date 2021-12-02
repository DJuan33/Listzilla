import 'dart:core';
import 'package:hive/hive.dart';

part 'task_list_model.g.dart';

@HiveType(typeId: 1)
class TaskList {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int index;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String emoji;

  @HiveField(4)
  final List<String?> tasksID;

  TaskList({
    required this.id,
    required this.index,
    required this.name,
    required this.emoji,
    required this.tasksID,
  });
}
