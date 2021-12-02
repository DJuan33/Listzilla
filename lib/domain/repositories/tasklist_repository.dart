import 'package:listzilla/domain/models/task_list_model.dart';

abstract class TaskListRepositoryInterface {

  void addTaskInTaskList(String taskID, String taskListID);

  void addTaskList(TaskList taskList);

  void deleteTaskList(String taskListID);

  List<String?> getTasks(String taskListID);

  TaskList? getTaskList(String taskListID);

  String newTaskList(String name, String emoji);

  void removeTaskInTaskList(String taskID, String taskListID);

  void updateTaskListEmoji(String newEmoji, String taskListID);

  void updateTaskListName(String newName, String taskListID);

  List<TaskList> getAllTaskLists();
}
