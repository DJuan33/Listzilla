import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/domain/controllers/task_detail/taskdetail_screen_state.dart';
import 'package:listzilla/domain/models/task_model.dart';
import 'package:listzilla/domain/repositories/task_repository.dart';

class TaskDetailScreenController extends Cubit<TaskDetailScreenState> {
  TaskRepositoryInterface taskDBConnection;

  TaskDetailScreenController({required this.taskDBConnection})
      : super(TaskDetailScreenState.initial);

  void deleteTask() {
    taskDBConnection.deleteTask(state.taskID);
  }

  void getTaskData() {
    Task? taskFinded = taskDBConnection.getTask(state.taskID);

    if (taskFinded != null) {
      emit(state.copyWith(
        taskCompleted: taskFinded.completed,
        taskCreationDate: taskFinded.creationDate,
        taskDescription: taskFinded.description,
        taskName: taskFinded.name,
        taskPriority: taskFinded.priority,
        taskMyDay: taskFinded.myDay,
        taskExpirationDate: taskFinded.expirationDate,
        taskPomodoro: taskFinded.pomodoro,
      ));
    }
  }

  void setTaskID(String newTaskID) {
    emit(state.copyWith(taskID: newTaskID));
    getTaskData();
  }

  void toggleTaskCompleted() {
    taskDBConnection.toggleTaskCompleted(state.taskID);
    getTaskData();
  }

  void toggleTaskPriority() {
    taskDBConnection.toggleTaskPriority(state.taskID);
    getTaskData();
  }

  void toggleTaskMyDay() {
    taskDBConnection.toggleTaskMyDay(state.taskID);
    getTaskData();
  }

  void updateDescription(String newDescription) {
    taskDBConnection.updateTaskDescription(newDescription, state.taskID);
    getTaskData();
  }

  void updateTaskName(String newName) {
    taskDBConnection.updateTaskName(newName, state.taskID);
    getTaskData();
  }

  void setExpirationDate(DateTime newExpirationDate) {
    taskDBConnection.setExpirationDate(newExpirationDate, state.taskID);
    getTaskData();
  }

  String getTaskDescription() {
    return state.taskDescription;
  }

  void setRememberDate(DateTime newRememberDate) {
    taskDBConnection.setExpirationDate(newRememberDate, state.taskID);
    getTaskData();
  }
}
