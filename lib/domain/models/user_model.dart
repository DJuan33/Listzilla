import 'dart:core';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 3)
class User {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final bool dataAdded;

  @HiveField(2)
  final int themeMode;

  @HiveField(3)
  final List<String?> groupListsID;

  @HiveField(4)
  final List<String?> pomodorosID;

  @HiveField(5)
  final int pomodoroLongBreakLength;

  @HiveField(6)
  final int pomodoroShortBreakLength;

  @HiveField(7)
  final int pomodorosLength;

  @HiveField(8)
  final int pomodorosToBreak;

  @HiveField(9)
  final int calendarWeekFirstDay;

  User({
      required this.id,
      required this.dataAdded,
      required this.themeMode,
      required this.groupListsID,
      required this.pomodorosID,
      required this.pomodoroLongBreakLength,
      required this.pomodoroShortBreakLength,
      required this.pomodorosLength,
      required this.pomodorosToBreak,
      required this.calendarWeekFirstDay,
  });
}
