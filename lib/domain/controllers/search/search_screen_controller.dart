import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/domain/controllers/search/search_screen_state.dart';
import 'package:listzilla/domain/models/task_model.dart';
import 'package:listzilla/domain/repositories/tasklist_repository.dart';
import 'package:listzilla/domain/repositories/task_repository.dart';

class SearchScreenController extends Cubit<SearchScreenState> {
  final TaskListRepositoryInterface taskListDBConnection;
  final TaskRepositoryInterface taskDBConnection;

  SearchScreenController({
    required this.taskListDBConnection,
    required this.taskDBConnection,
  }) : super(SearchScreenState.initial);

  void onInit() {
    searchTasks(state.searchTerm);
  }

  void splitTasks() {
    List<Task?> tasksCompleted = [];
    List<Task?> tasksUncompleted = [];

    for (var x in state.tasks) {
      if (x != null) {
        if (x.completed) {
          tasksCompleted.add(x);
        } else {
          tasksUncompleted.add(x);
        }
      }
    }

    /* this.tasksCompleted.value = tasksCompleted; */
    /* this.tasksUncompleted.value = tasksUncompleted; */

    emit(state.copyWith(
      tasksCompleted: tasksCompleted,
      tasksUncompleted: tasksUncompleted,
    ));
  }

  void searchTasks(String newSearchTerm) {
    if (newSearchTerm != "") {
      /* searchTerm = newSearchTerm; */
      List<Task?> tasksFinded = taskDBConnection.searchTasks(newSearchTerm);
      emit(state.copyWith(
        searchTerm: newSearchTerm,
        tasks: tasksFinded,
      ));
      splitTasks();
    }
  }

  void toggleTaskPriority(String taskID) {
    taskDBConnection.toggleTaskPriority(taskID);
    searchTasks(state.searchTerm);
  }

  void toggleTaskCompleted(String taskID) {
    taskDBConnection.toggleTaskCompleted(taskID);
    searchTasks(state.searchTerm);
  }
}
