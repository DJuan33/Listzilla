import 'package:listzilla/domain/models/task_list_model.dart';
import 'package:listzilla/domain/repositories/tasklist_repository.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class TaskListRepositoryHive implements TaskListRepositoryInterface {
  Box<TaskList> taskListBox = Hive.box('LIST');

  @override
  void addTaskInTaskList(String taskID, String taskListID) {
    TaskList? taskList = getTaskList(taskListID);

    if (taskList != null) {
      taskList.tasksID.add(taskID);
      taskListBox.put(taskList.id, taskList);
    }
  }

  @override
  void addTaskList(TaskList taskList) {
    taskListBox.put(taskList.id, taskList);
  }

  @override
  void deleteTaskList(String taskListID) {
    TaskList? taskList = getTaskList(taskListID);

    if (taskList != null) {
      taskListBox.delete(taskList.id);
    }
  }

  @override
  TaskList? getTaskList(String taskListID) => taskListBox.get(taskListID);

  @override
  String newTaskList(String name, String emoji) {
    int newTaskListIndex = taskListBox.values.length;
    String newTaskListID = const Uuid().v4();

    TaskList newTaskList = TaskList(
        id: newTaskListID,
        index: newTaskListIndex,
        name: name,
        emoji: emoji,
        tasksID: []);

    addTaskList(newTaskList);
    return newTaskListID;
  }

  @override
  void removeTaskInTaskList(String taskID, String taskListID) {
    TaskList? listFinded = getTaskList(taskListID);

    if (listFinded != null) {
      List<String?> newTasks = [];

      for (var x in listFinded.tasksID) {
        if (x != taskID) {
          newTasks.add(x);
        }
      }

      TaskList taskListUpdated = TaskList(
          id: listFinded.id,
          index: listFinded.index,
          name: listFinded.name,
          emoji: listFinded.emoji,
          tasksID: newTasks);

      taskListBox.put(taskListUpdated.id, taskListUpdated);
    }
  }

  @override
  void updateTaskListEmoji(String newEmoji, String taskListID) {
    TaskList? listFinded = getTaskList(taskListID);

    if (listFinded != null) {
      TaskList taskListUpdated = TaskList(
          id: listFinded.id,
          index: listFinded.index,
          name: listFinded.name,
          emoji: newEmoji,
          tasksID: listFinded.tasksID);

      taskListBox.put(taskListUpdated.id, taskListUpdated);
    }
  }

  @override
  void updateTaskListName(String newName, String taskListID) {
    TaskList? listFinded = getTaskList(taskListID);

    if (listFinded != null) {
      TaskList taskListUpdated = TaskList(
          id: listFinded.id,
          index: listFinded.index,
          name: newName,
          emoji: listFinded.emoji,
          tasksID: listFinded.tasksID);

      taskListBox.put(taskListUpdated.id, taskListUpdated);
    }
  }

  @override
  List<String?> getTasks(String taskListID) {
    TaskList? listFinded = getTaskList(taskListID);
    List<String?> tasks = [];

    if (listFinded != null) {
      tasks = listFinded.tasksID;
    }

    return tasks;
  }

  @override
  List<TaskList> getAllTaskLists(){
      return taskListBox.values.toList();
    }
}
