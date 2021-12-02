import 'package:equatable/equatable.dart';
import 'package:listzilla/domain/models/task_model.dart';

/// This class defines the State for the `TasklistScreenController`.
class TaskListScreenState extends Equatable {
  final String taskListID;
  final String name;
  final String emoji;
  final List<Task?> tasks;
  final List<Task?> tasksCompleted;
  final List<Task?> tasksUncompleted;
  final bool listCanBeDeleted;

  const TaskListScreenState({
    required this.taskListID,
    required this.name,
    required this.emoji,
    required this.tasks,
    required this.tasksCompleted,
    required this.tasksUncompleted,
    required this.listCanBeDeleted,
  });

  TaskListScreenState copyWith({
    String? taskListID,
    String? name,
    String? emoji,
    List<Task?>? tasks,
    List<Task?>? tasksCompleted,
    List<Task?>? tasksUncompleted,
    bool? listCanBeDeleted,
  }) {
    return TaskListScreenState(
      taskListID: taskListID ?? this.taskListID,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      tasks: tasks ?? this.tasks,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      tasksUncompleted: tasksUncompleted ?? this.tasksUncompleted,
      listCanBeDeleted: listCanBeDeleted ?? this.listCanBeDeleted,
    );
  }

  static TaskListScreenState initial = const TaskListScreenState(
    taskListID: "",
    name: "",
    emoji: "",
    tasks: [],
    tasksCompleted: [],
    tasksUncompleted: [],
    listCanBeDeleted: true,
  );

  @override
  List<Object?> get props => [
        taskListID,
        name,
        emoji,
        tasks,
        tasksCompleted,
        tasksUncompleted,
        listCanBeDeleted,
      ];
}
