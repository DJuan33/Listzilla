import 'package:equatable/equatable.dart';

class TaskDetailScreenState extends Equatable {
  final String taskID;
  final String taskName;
  final bool taskCompleted;
  final bool taskPriority;
  final bool taskMyDay;
  final String taskDescription;
  final DateTime taskCreationDate;
  final DateTime taskExpirationDate;
  final DateTime taskPomodoro;

  const TaskDetailScreenState({
    required this.taskID,
    required this.taskName,
    required this.taskCompleted,
    required this.taskPriority,
    required this.taskMyDay,
    required this.taskDescription,
    required this.taskCreationDate,
    required this.taskExpirationDate,
    required this.taskPomodoro,
  });

  TaskDetailScreenState copyWith({
    String? taskID,
    String? taskName,
    bool? taskCompleted,
    bool? taskPriority,
    bool? taskMyDay,
    String? taskDescription,
    DateTime? taskCreationDate,
    DateTime? taskExpirationDate,
    DateTime? taskPomodoro,
  }) {
    return TaskDetailScreenState(
      taskID: taskID ?? this.taskID,
      taskName: taskName ?? this.taskName,
      taskCompleted: taskCompleted ?? this.taskCompleted,
      taskPriority: taskPriority ?? this.taskPriority,
      taskMyDay: taskMyDay ?? this.taskMyDay,
      taskDescription: taskDescription ?? this.taskDescription,
      taskExpirationDate: taskExpirationDate ?? this.taskExpirationDate,
      taskCreationDate: taskCreationDate ?? this.taskCreationDate,
      taskPomodoro: taskPomodoro ?? this.taskPomodoro,
    );
  }

  static TaskDetailScreenState initial = TaskDetailScreenState(
    taskID: "0",
    taskName: "",
    taskCompleted: false,
    taskPriority: false,
    taskMyDay: false,
    taskDescription: "",
    taskExpirationDate: DateTime.fromMicrosecondsSinceEpoch(0),
    taskCreationDate: DateTime.fromMicrosecondsSinceEpoch(0),
    taskPomodoro: DateTime.fromMicrosecondsSinceEpoch(0),
  );

  @override
  // TODO: implement props
  List<Object?> get props => [
        taskID,
        taskName,
        taskCompleted,
        taskPriority,
        taskMyDay,
        taskDescription,
        taskCreationDate,
        taskExpirationDate,
        taskPomodoro,
      ];
}
