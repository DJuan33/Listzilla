import 'package:hive/hive.dart';
import 'package:listzilla/domain/models/task_model.dart';
import 'package:listzilla/domain/repositories/task_repository.dart';
import 'package:uuid/uuid.dart';

class TaskRepositoryHive implements TaskRepositoryInterface {
  Box<Task> taskBox = Hive.box('TASK');

  @override
  void addTask(Task task) {
    taskBox.put(task.id, task);
  }

  @override
  void deleteTask(String taskID) {
    Task? task = getTask(taskID);

    if (task != null) {
      taskBox.delete(task.id);
    }
  }

  @override
  List<Task?> getAllPriorityTasks() {
    List<Task?> tasksFinded = [];

    for (var x in taskBox.keys) {
      Task? finded = getTask(x);

      if (finded != null) {
        if (finded.priority) {
          tasksFinded.add(finded);
        }
      }
    }

    return tasksFinded;
  }

  @override
  List<Task?> getMyDayTasks() {
    List<Task?> tasksFinded = [];

    for (var x in taskBox.keys) {
      Task? finded = getTask(x);

      if (finded != null) {
        if (finded.myDay) {
          tasksFinded.add(finded);
        }
      }
    }

    return tasksFinded;
  }

  @override
  Task? getTask(String taskID) {
    Task? taskFinded = taskBox.get(taskID);
    return taskFinded;
  }

  Box<Task> getTaskController() => taskBox;

  @override
  String newTask(String newTaskName, String newTaskDescription,
      bool newTaskPriority, DateTime newTaskExpirationDate, bool myDay) {
    int newTaskIndex = taskBox.values.length;
    String newTaskID = const Uuid().v4();
    DateTime newTaskCreationDate = DateTime.now();
    DateTime newTaskRememberDate = DateTime.fromMillisecondsSinceEpoch(0);

    Task newTask = Task(
      id: newTaskID,
      index: newTaskIndex,
      name: newTaskName,
      description: newTaskDescription,
      completed: false,
      priority: newTaskPriority,
      creationDate: newTaskCreationDate,
      pomodoro: newTaskRememberDate,
      myDay: myDay,
      expirationDate: newTaskExpirationDate,
    );

    addTask(newTask);
    return newTaskID;
  }

  @override
  List<Task?> searchTasks(String searchTerm) {
    //Case sensitive variables
    String searchTermUppercase = searchTerm.toUpperCase();
    String searchTermLowercase = searchTerm.toLowerCase();
    String searchTermCapitalized = searchTerm.isNotEmpty
        ? "${searchTerm[0].toUpperCase()}${searchTerm.substring(1)}"
        : '';

    List<Task> tasksFinded = [];
    Iterable<dynamic> tasks = taskBox.keys;

    for (var x in tasks) {
      Task? finded = getTask(x);
      if (finded != null) {
        if (finded.name.contains(searchTerm) ||
            finded.name.contains(searchTermLowercase) ||
            finded.name.contains(searchTermUppercase) ||
            finded.name.contains(searchTermCapitalized)) {
          tasksFinded.add(finded);
        }
      }
    }

    return tasksFinded;
  }

  @override
  void toggleTaskCompleted(String taskID) {
    Task? taskFinded = getTask(taskID);

    if (taskFinded != null) {
      taskBox.delete(taskFinded.id);

      Task newTask = Task(
          id: taskFinded.id,
          index: taskFinded.index,
          name: taskFinded.name,
          completed: !taskFinded.completed,
          priority: taskFinded.priority,
          description: taskFinded.description,
          creationDate: taskFinded.creationDate,
          pomodoro: taskFinded.pomodoro,
          myDay: taskFinded.myDay,
          expirationDate: taskFinded.expirationDate,
          );

      taskBox.put(newTask.id, newTask);
    }
  }

  @override
  void toggleTaskMyDay(String taskID) {
    Task? taskFinded = getTask(taskID);

    if (taskFinded != null) {
      taskBox.delete(taskFinded.id);

      Task newTask = Task(
          id: taskFinded.id,
          index: taskFinded.index,
          name: taskFinded.name,
          completed: taskFinded.completed,
          priority: taskFinded.priority,
          description: taskFinded.description,
          creationDate: taskFinded.creationDate,
          pomodoro: taskFinded.pomodoro,
          myDay: !taskFinded.myDay,
          expirationDate: taskFinded.expirationDate,
          );

      taskBox.put(newTask.id, newTask);
    }
  }

  @override
  void toggleTaskPriority(String taskID) {
    Task? taskFinded = getTask(taskID);

    if (taskFinded != null) {
      taskBox.delete(taskFinded.id);

      Task newTask = Task(
          id: taskFinded.id,
          index: taskFinded.index,
          name: taskFinded.name,
          completed: taskFinded.completed,
          priority: !taskFinded.priority,
          description: taskFinded.description,
          creationDate: taskFinded.creationDate,
          pomodoro: taskFinded.pomodoro,
          myDay: taskFinded.myDay,
          expirationDate: taskFinded.expirationDate,
          );

      taskBox.put(newTask.id, newTask);
    }
  }

  @override
  void updateTaskDescription(String newDescription, String taskID) {
    Task? taskFinded = getTask(taskID);

    if (taskFinded != null) {
      taskBox.delete(taskFinded.id);

      Task newTask = Task(
          id: taskFinded.id,
          index: taskFinded.index,
          name: taskFinded.name,
          completed: taskFinded.completed,
          priority: taskFinded.priority,
          description: newDescription,
          creationDate: taskFinded.creationDate,
          pomodoro: taskFinded.pomodoro,
          myDay: taskFinded.myDay,
          expirationDate: taskFinded.expirationDate,
          );

      taskBox.put(newTask.id, newTask);
    }
  }

  @override
  void updateTaskName(String newName, String taskID) {
    Task? taskFinded = getTask(taskID);

    if (taskFinded != null) {
      taskBox.delete(taskFinded.id);

      Task newTask = Task(
          id: taskFinded.id,
          index: taskFinded.index,
          name: newName,
          completed: taskFinded.completed,
          priority: taskFinded.priority,
          description: taskFinded.description,
          creationDate: taskFinded.creationDate,
          pomodoro: taskFinded.pomodoro,
          myDay: taskFinded.myDay,
          expirationDate: taskFinded.expirationDate,
          );

      taskBox.put(newTask.id, newTask);
    }
  }

  @override
  void setExpirationDate(DateTime newExpirationDate, String taskID) {
    Task? taskFinded = getTask(taskID);

    if (taskFinded != null) {
      taskBox.delete(taskFinded.id);

      Task newTask = Task(
          id: taskFinded.id,
          index: taskFinded.index,
          name: taskFinded.name,
          completed: taskFinded.completed,
          priority: taskFinded.priority,
          description: taskFinded.description,
          creationDate: taskFinded.creationDate,
          pomodoro: taskFinded.pomodoro,
          myDay: taskFinded.myDay,
          expirationDate: newExpirationDate,
          );

      taskBox.put(newTask.id, newTask);
    }
  }

  @override
  void setRememberDate(DateTime newRememberDate, String taskID) {
    Task? taskFinded = getTask(taskID);

    if (taskFinded != null) {
      taskBox.delete(taskFinded.id);

      Task newTask = Task(
          id: taskFinded.id,
          index: taskFinded.index,
          name: taskFinded.name,
          completed: taskFinded.completed,
          priority: taskFinded.priority,
          description: taskFinded.description,
          creationDate: taskFinded.creationDate,
          pomodoro: newRememberDate,
          myDay: taskFinded.myDay,
          expirationDate: taskFinded.expirationDate,
          );

      taskBox.put(newTask.id, newTask);
    }
  }

  @override
  Map<DateTime, List<Task>> getTasksByDate() {
    Map<DateTime, List<Task>> tasksByDate = {};

    for (var x in taskBox.keys) {
      Task? finded = getTask(x);
      if (finded != null) {
        if (finded.expirationDate != DateTime.fromMillisecondsSinceEpoch(0)) {
            DateTime mapKey = DateTime.utc(finded.expirationDate.year,finded.expirationDate.month,finded.expirationDate.day,);
          if (tasksByDate[mapKey] != null) {
            

            tasksByDate[mapKey] = [
              ...tasksByDate[mapKey]!,
              finded
            ];
          } else {
            tasksByDate[mapKey] = [finded];
          }
        }
      }
    }

    return tasksByDate;
  }
}
