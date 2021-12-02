import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/UI/global_widgets/task_card.dart';
import 'package:listzilla/UI/screens/task_list/widgets/tasklist_topbar.dart';
import 'package:listzilla/domain/controllers/app_theme/app_theme_controller.dart';
import 'package:listzilla/domain/controllers/sidebar/sidebar_screen_controller.dart';
import 'package:listzilla/domain/controllers/task_detail/taskdetail_screen_controller.dart';
import 'package:listzilla/domain/controllers/tasklist/tasklist_screen_controller.dart';
import 'package:listzilla/domain/controllers/tasklist/tasklist_screen_state.dart';
import 'package:listzilla/domain/models/task_model.dart';

class TaskListScreen extends StatelessWidget {
  final TaskListScreenController _taskListScreenController =
      AppDependencies.dependencyInjector.resolve();

  final SidebarScreenController _sidebarScreenController =
      AppDependencies.dependencyInjector.resolve();

  final TaskDetailScreenController _taskDetailScreenController =
      AppDependencies.dependencyInjector.resolve();

  final AppThemeController _appThemeController =
      AppDependencies.dependencyInjector.resolve();

  TaskListScreen({Key? key}) : super(key: key);

  void setTaskList(String taskListID) {
    _taskListScreenController.setTaskListID(taskListID);
  }

  /// Returns a bool that indicate if the app is running in a mobile screen size.
  bool isMobileScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width <= 1200;
  }

  void togglePriority(String taskID) {
    _taskListScreenController.toggleTaskPriority(taskID);
    _taskDetailScreenController.setTaskID(taskID);
  }

  void toggleCompleted(String taskID) {
    _taskListScreenController.toggleTaskCompleted(taskID);
    _taskDetailScreenController.setTaskID(taskID);
  }

  void deleteTaskList(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Delete list",
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          content: Text(
            "Are you sure want to delete this list?",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("OK"),
            )
          ],
        );
      },
    ).then((delete) {
      if (delete) {
        _taskListScreenController.deleteTaskList();
        _appThemeController.setPrimaryColor(0);
        _sidebarScreenController.onInit();
      }
    });
  }

  ListView getUncompletedTasks(List<Task?> tasksUncompleted) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tasksUncompleted.length,
        itemBuilder: (context, index) {
          Task? task = tasksUncompleted[index];

          if (task != null) {
            return TaskCard(
                taskName: task.name,
                taskID: task.id,
                taskCompleted: task.completed,
                taskPriority: task.priority,
                completedFunction: () => toggleCompleted(task.id),
                priorityFunction: () => togglePriority(task.id));
          } else {
            return const Text("a");
          }
        });
  }

  ListView getCompletedTasks(List<Task?> tasksCompleted) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tasksCompleted.length,
        itemBuilder: (context, index) {
          Task? task = tasksCompleted[index];

          if (task != null) {
            return TaskCard(
                taskName: task.name,
                taskID: task.id,
                taskCompleted: task.completed,
                taskPriority: task.priority,
                completedFunction: () => toggleCompleted(task.id),
                priorityFunction: () => togglePriority(task.id));
          } else {
            return const Text("a");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListScreenController, TaskListScreenState>(
      bloc: _taskListScreenController,
      builder: (context, state) {
        ThemeData themeContext = Theme.of(context);

        // TODO: Add loading screen.
        return ListView(
          children: [
            TaskListTopbar(
              taskListName: state.name,
              taskListEmoji: state.emoji,
              orderByPriorityFunction:
                  _taskListScreenController.orderTasksByPriority,
              orderByDateFunction: _taskListScreenController.orderTasksByDate,
              deleteTaskListFunction: () => deleteTaskList(context),
              deleteableList: state.listCanBeDeleted,
            ),
            if (state.tasksCompleted.isEmpty && state.tasksUncompleted.isEmpty)
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 33),
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: DottedBorder(
                    color: Colors.grey,
                    radius: const Radius.circular(100),
                    strokeWidth: 3,
                    dashPattern: const [6, 2],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 33, horizontal: 33),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 33.0),
                            child: Icon(
                              Icons.task_alt_rounded,
                              color: Colors.grey,
                              size: 66,
                            ),
                          ),
                          Text(
                            "Empty list\nTry to add some tasks",
                            style: themeContext.textTheme.bodyText2!.copyWith(
                              color: Colors.grey,
                              fontSize: 33,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            else
              ...tasksWidgets(
                  state.tasksCompleted, state.tasksUncompleted, themeContext),
          ],
        );
      },
    );
  }

  List<Widget> tasksWidgets(List<Task?> tasksCompleted,
      List<Task?> tasksUncompleted, ThemeData themeContext) {
    return [
      getUncompletedTasks(tasksUncompleted),
      Theme(
        data: themeContext.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text(
            "Done".toUpperCase(),
            style: themeContext.textTheme.bodyText1,
          ),
          children: [getCompletedTasks(tasksCompleted)],
        ),
      )
    ];
  }
}
