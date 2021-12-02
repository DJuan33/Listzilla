import 'package:listzilla/domain/models/group_list_model.dart';
import 'package:listzilla/domain/models/task_list_model.dart';
import 'package:listzilla/domain/models/task_model.dart';
import 'package:listzilla/domain/repositories/grouplist_repository.dart';
import 'package:listzilla/domain/repositories/tasklist_repository.dart';
import 'package:listzilla/domain/repositories/task_repository.dart';

class InitialData {
  TaskRepositoryInterface taskDBConnection;
  TaskListRepositoryInterface taskListDBConnection;
  GroupListRepositoryInterface groupListDBConnection;

  InitialData({
    required this.groupListDBConnection,
    required this.taskDBConnection,
    required this.taskListDBConnection,
  });

  void addInitialData() async {
    _addGroupLists();
    _addTaskLists();
    _addTasks();
  }

  void _addGroupLists() {
    GroupList groupList1 = GroupList(
      id: "333-333-333",
      index: 0,
      name: "default",
      colorTag: 0,
      listsID: ["My day", "Priority", "1b3c31d6-19c6-428c-9332-99d87bfa840b"],
    );

    GroupList groupList2 = GroupList(
      id: "2d142104-95bd-4be7-87ae-8db4301a2e3f",
      index: 1,
      name: "Listzilla",
      colorTag: 1,
      listsID: [
        "ba531147-6366-45f1-9fcf-2c90d2d2fab4",
        "bc2c7633-2ea0-4f31-a937-ab92b4ee10e1"
      ],
    );

    groupListDBConnection.addGroupList(groupList1);
    groupListDBConnection.addGroupList(groupList2);
  }

  void _addTaskLists() {
    TaskList taskList2 = TaskList(
      id: "My day",
      index: 0,
      name: "My day",
      emoji: "",
      tasksID: [],
    );

    TaskList taskList1 = TaskList(
      id: "Priority",
      index: 1,
      name: "Priority",
      emoji: "",
      tasksID: [],
    );

    TaskList taskList3 = TaskList(
      id: "1b3c31d6-19c6-428c-9332-99d87bfa840b",
      index: 2,
      name: "Task lists",
      emoji: "📚",
      tasksID: [
        "a22e7624-9d1e-4e6f-9e72-9d84a907a6a8",
        "0108802d-506b-4427-b5f6-b8349b9b75e3",
        "6914188a-b18d-4acc-bbc0-f37ca5b4bde6",
        "8416a6b7-1b44-4b9a-b054-986c7755e4d6",
      ],
    );

    TaskList taskList4 = TaskList(
      id: "bc2c7633-2ea0-4f31-a937-ab92b4ee10e1",
      index: 0,
      name: "Calendar",
      emoji: "📆",
      tasksID: [
        "e0e7b9bb-f1c4-4fd7-bc66-e3dfe3381d93",
        "079a6f29-8016-413c-989c-723508db96f3",
      ],
    );

    TaskList taskList5 = TaskList(
      id: "ba531147-6366-45f1-9fcf-2c90d2d2fab4",
      index: 1,
      name: "Pomodoro",
      emoji: "🍅",
      tasksID: [
        "bce8025c-02be-450d-a3a3-b04307c1dbd2",
        "9852978b-4519-4171-bc83-188c922d5e25",
      ],
    );

    taskListDBConnection.addTaskList(taskList1);
    taskListDBConnection.addTaskList(taskList2);
    taskListDBConnection.addTaskList(taskList3);
    taskListDBConnection.addTaskList(taskList4);
    taskListDBConnection.addTaskList(taskList5);
  }

  void _addTasks() {
    Task task1 = Task(
      id: "0108802d-506b-4427-b5f6-b8349b9b75e3",
      index: 0,
      name: "Tap this task",
      completed: false,
      priority: true,
      description:
          "This is a task. From here, you can add a description, priority and even an expiration day. Try to complete it!",
      creationDate: DateTime.now(),
      pomodoro: DateTime.fromMillisecondsSinceEpoch(0),
      myDay: true,
      expirationDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        23,
        59,
      ),
    );

    Task task2 = Task(
      id: "6914188a-b18d-4acc-bbc0-f37ca5b4bde6",
      index: 1,
      name: "Explore Priority and MyDay lists",
      completed: false,
      priority: true,
      description:
          "You can access to all your priority tasks from the list named 'Priority'. Also, you can set a Task as a 'My day' and see it in the 'My day' list.",
      creationDate: DateTime.now(),
      pomodoro: DateTime.fromMillisecondsSinceEpoch(0),
      myDay: true,
      expirationDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        23,
        59,
      ),
    );

    Task task3 = Task(
      id: "a22e7624-9d1e-4e6f-9e72-9d84a907a6a8",
      index: 2,
      name: "Checking groups and lists",
      completed: false,
      priority: false,
      description:
          "Use the sidebar to explore another groups and lists. Try to go to the 'Task list' list.",
      creationDate: DateTime.now(),
      pomodoro: DateTime.fromMillisecondsSinceEpoch(0),
      myDay: false,
      expirationDate: DateTime.fromMillisecondsSinceEpoch(0),
    );

    Task task10 = Task(
      id: "8416a6b7-1b44-4b9a-b054-986c7755e4d6",
      index: 2,
      name: "Adding task, lists and groups",
      completed: false,
      priority: false,
      description:
          "Try to add a task tapping in the button with the task icon at the bottom right of the app. Also, you can add a list or a group using the buttoms at bottom of sidebar or tapping the menu button of a group tile.",
      creationDate: DateTime.now(),
      pomodoro: DateTime.fromMillisecondsSinceEpoch(0),
      myDay: false,
      expirationDate: DateTime.fromMillisecondsSinceEpoch(0),
    );

    Task task5 = Task(
      id: "079a6f29-8016-413c-989c-723508db96f3",
      index: 1,
      name: "Basics of Calendar",
      completed: false,
      priority: true,
      description:
          "In the calendar section, you can check the tasks by their expiration day. Try to tap the day of today to see the tasks!",
      creationDate: DateTime.now(),
      pomodoro: DateTime.fromMillisecondsSinceEpoch(0),
      myDay: false,
      expirationDate: DateTime.fromMillisecondsSinceEpoch(0),
    );

    Task task6 = Task(
      id: "e0e7b9bb-f1c4-4fd7-bc66-e3dfe3381d93",
      index: 2,
      name: "Adding an expiration day",
      completed: false,
      priority: false,
      description:
          "To add an expirantion date and see the task in the calendar, open the task and tap the 'Set expiration day button'. If a task has already set an expiration date, you can tap it again to modify the date. Try add this day for tomorrow!",
      creationDate: DateTime.now(),
      pomodoro: DateTime.fromMillisecondsSinceEpoch(0),
      myDay: true,
      expirationDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        23,
        59,
      ),
    );

    Task task7 = Task(
      id: "9852978b-4519-4171-bc83-188c922d5e25",
      index: 0,
      name: "Basics of pomodoro",
      completed: false,
      priority: true,
      description:
          "You can use the Pomodoro productivity technique in the 'Pomodoro' section. The app will show you the remain pomodoro and breaks times and the focused time the last week.",
      creationDate: DateTime.now(),
      pomodoro: DateTime.fromMillisecondsSinceEpoch(0),
      myDay: false,
      expirationDate: DateTime.fromMillisecondsSinceEpoch(0),
    );

    Task task8 = Task(
      id: "bce8025c-02be-450d-a3a3-b04307c1dbd2",
      index: 1,
      name: "Customizing your pomodoro timer",
      completed: false,
      priority: false,
      description:
          "Tapping the menu button in the app bar of the pomodoro section, you can customize the duration of the pomodoro timer, the short break and the long break to adjust it to your needs.",
      creationDate: DateTime.now(),
      pomodoro: DateTime.fromMillisecondsSinceEpoch(0),
      myDay: false,
      expirationDate: DateTime.fromMillisecondsSinceEpoch(0),
    );

    taskDBConnection.addTask(task1);
    taskDBConnection.addTask(task2);
    taskDBConnection.addTask(task3);
    taskDBConnection.addTask(task5);
    taskDBConnection.addTask(task6);
    taskDBConnection.addTask(task7);
    taskDBConnection.addTask(task8);
    taskDBConnection.addTask(task10);
  }
}
