import 'package:listzilla/domain/models/task_model.dart';

abstract class TaskRepositoryInterface {
  void addTask(Task task);

  void deleteTask(String taskID);

  List<Task?> getAllPriorityTasks();

  List<Task?> getMyDayTasks();

  Task? getTask(String taskID);

  String newTask(
      String newTaskName,
      String newTaskDescription,
      bool newTaskPriority,
      DateTime newTaskExpirationDate,
      bool myDay,);

  List<Task?> searchTasks(String searchTerm);

  void toggleTaskCompleted(String taskID);

  void toggleTaskMyDay(String taskID);

  void toggleTaskPriority(String taskID);

  void updateTaskDescription(String newDescription, String taskID);

  void updateTaskName(String newName, String taskID);

  void setExpirationDate(DateTime newExpirationDate, String taskID);

  void setRememberDate(DateTime newRememberDate, String taskID);

  Map<DateTime, List<Task>> getTasksByDate();
}
