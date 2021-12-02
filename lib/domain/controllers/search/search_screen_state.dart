import 'package:equatable/equatable.dart';
import 'package:listzilla/domain/models/task_model.dart';

/// This class defines the State for the `TasklistScreenController`.
class SearchScreenState extends Equatable {
  final String searchTerm;
  final List<Task?> tasks;
  final List<Task?> tasksCompleted;
  final List<Task?> tasksUncompleted;

  const SearchScreenState({
    required this.searchTerm,
    required this.tasks,
    required this.tasksCompleted,
    required this.tasksUncompleted,
  });

  SearchScreenState copyWith({
    String? searchTerm,
    List<Task?>? tasks,
    List<Task?>? tasksCompleted,
    List<Task?>? tasksUncompleted,
  }) {
    return SearchScreenState(
      searchTerm: searchTerm ?? this.searchTerm,
      tasks: tasks ?? this.tasks,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      tasksUncompleted: tasksUncompleted ?? this.tasksUncompleted,
    );
  }

  static SearchScreenState initial = const SearchScreenState(
    searchTerm: "",
    tasks: [],
    tasksCompleted: [],
    tasksUncompleted: [],
  );

  @override
  List<Object?> get props => [
        searchTerm,
        tasks,
        tasksCompleted,
        tasksUncompleted,
      ];
}

