import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/domain/controllers/tasklist/tasklist_screen_state.dart';
import 'package:listzilla/domain/models/task_list_model.dart';
import 'package:listzilla/domain/models/task_model.dart';
import 'package:listzilla/domain/repositories/tasklist_repository.dart';
import 'package:listzilla/domain/repositories/task_repository.dart';

class TaskListScreenController extends Cubit<TaskListScreenState> {
  TaskListRepositoryInterface taskListDBConnection;
  TaskRepositoryInterface taskDBConnection;
  TaskListScreenController({
    required this.taskDBConnection,
    required this.taskListDBConnection,
  }) : super(TaskListScreenState.initial);

  void onInit() {
    setTaskListID("Priority");
    setListUnDeleteable(false);
  }

  void newTask({
    required String taskName,
    required String taskDescription,
    required bool taskPriority,
    required DateTime taskExpirationDate,
    required bool taskMyDay
  }) {

    String newTaskID = taskDBConnection.newTask(
      taskName,
      taskDescription,
      taskPriority,
      taskExpirationDate,
      taskMyDay,
    );
    taskListDBConnection.addTaskInTaskList(newTaskID, state.taskListID);
    getTaskListData();
  }

  void refresh(){
    setTaskListID(state.taskListID);
  }

  bool actualListIsPriority(){
      return state.taskListID == "Priority";
  }

  bool actualListIsMyDay(){
      return state.taskListID == "My day";
  }

  void getTaskListData() {
    TaskList? taskListFinded =
        taskListDBConnection.getTaskList(state.taskListID);

    String name = "";
    String emoji = "";
    List<Task?> tasks = [];

    if (taskListFinded != null) {
      if (taskListFinded.id == "Priority") {
        name = taskListFinded.name;
        emoji = taskListFinded.emoji;
        tasks = getAllPriorityTasksID();
      } else if (taskListFinded.id == "My day") {
        name = taskListFinded.name;
        emoji = taskListFinded.emoji;
        tasks = getMyDayTasksID();
      } else {
        name = taskListFinded.name;
        emoji = taskListFinded.emoji;
        tasks = getTasks(taskListFinded);
      }
      splitTasks(tasks);

      emit(state.copyWith(
        name: name,
        emoji: emoji,
        tasks: tasks,
      ));
    }
  }

  void splitTasks(List<Task?> tasks) {
    List<Task?> tasksCompleted = [];
    List<Task?> tasksUncompleted = [];

    for (var x in tasks) {
      if (x != null) {
        if (x.completed) {
          tasksCompleted.add(x);
        } else {
          tasksUncompleted.add(x);
        }
      }
    }

    emit(state.copyWith(
      tasksCompleted: tasksCompleted,
      tasksUncompleted: tasksUncompleted,
    ));
  }

  void orderTasksByPriority() {
    List<Task?> priorityTasks = [];
    List<Task?> noPriorityTasks = [];

    for (var x in state.tasks) {
      if (x != null) {
        if (x.priority) {
          priorityTasks.add(x);
        } else {
          noPriorityTasks.add(x);
        }
      }
    }

    splitTasks([...priorityTasks, ...noPriorityTasks]);
  }

  void orderTasksByDate() {
    List<Task?> orderedTasks = quickSort(state.tasks);

    splitTasks(orderedTasks);
  }

  List<Task?> quickSort(List<Task?> list) {
    Task? pivot = list.isNotEmpty ? list[0] : null;

    if (list.isEmpty || pivot == null) {
      return [];
    }

    List<Task?> left = [];
    List<Task?> right = [];

    for (var x = 1; x < list.length; x++) {
      if (list[x] != null) {
        if (list[x]!.creationDate.isAfter(pivot.creationDate)) {
          left.add(list[x]);
        } else {
          right.add(list[x]);
        }
      }
    }
    return [...quickSort(left), pivot, ...quickSort(right)];
  }

  void setTaskListID(String newTaskListID) {
    emit(state.copyWith(
      taskListID: newTaskListID,
    ));
    getTaskListData();
  }

  void setListUnDeleteable(bool deleteable) {
    emit(state.copyWith(listCanBeDeleted: deleteable));
  }

  void deleteTaskList() {
    taskListDBConnection.deleteTaskList(state.taskListID);
    for (var x in state.tasks) {
      if (x != null) {
        taskDBConnection.deleteTask(x.id);
      }
    }
    onInit();
  }

  List<Task?> getTasks(TaskList taskList) {
    List<Task?> tasksFinded = [];

    for (var x in taskList.tasksID) {
      if (x != null) {
        Task? taskFinded = taskDBConnection.getTask(x);
        if (taskFinded != null) {
          tasksFinded.add(taskFinded);
        }
      }
    }

    return tasksFinded;
  }

  List<Task?> getAllPriorityTasksID() {
    List<Task?> priorityTasks = taskDBConnection.getAllPriorityTasks();

    return priorityTasks;
  }

  List<Task?> getMyDayTasksID() {
    List<Task?> myDayTasks = taskDBConnection.getMyDayTasks();

    return myDayTasks;
  }

  void toggleTaskPriority(String taskID) {
    taskDBConnection.toggleTaskPriority(taskID);
    getTaskListData();
  }

  void toggleTaskCompleted(String taskID) {
    taskDBConnection.toggleTaskCompleted(taskID);
    getTaskListData();
  }

  List<TaskList> getAllTaskLists() {
    return taskListDBConnection.getAllTaskLists();
  }
}
