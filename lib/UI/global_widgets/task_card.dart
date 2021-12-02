import 'package:flutter/material.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/UI/routes_names.dart';
import 'package:listzilla/domain/controllers/home/home_screen_controller.dart';
import 'package:listzilla/domain/controllers/task_detail/taskdetail_screen_controller.dart';

class TaskCard extends StatelessWidget {
  // Task Widget Data
  final String taskName;
  final String taskID;
  final bool taskCompleted;
  final bool taskPriority;
  final Function completedFunction;
  final Function priorityFunction;

  final TaskDetailScreenController _taskDetailScreenController =
      AppDependencies.dependencyInjector.resolve();

  final HomeScreenController _homeScreenController = AppDependencies.dependencyInjector.resolve();

  TaskCard(
      {Key? key,
      required this.taskName,
      required this.taskID,
      required this.taskCompleted,
      required this.taskPriority,
      required this.completedFunction,
      required this.priorityFunction})
      : super(key: key);

  /// Returns a bool that indicate if the app is running in a mobile screen size.
  bool isMobileScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width <= 1200;
  }

  @override
  Widget build(BuildContext context) {
    // App UI Color
    final Color color = Theme.of(context).colorScheme.primary;

    // Icons
    final Icon undoneIcon = Icon(
      Icons.radio_button_unchecked,
      color: color,
      size: 24,
    );

    final Icon doneIcon = Icon(
      Icons.check_circle,
      color: color,
      size: 24,
    );

    final Icon priorityIcon = Icon(
      Icons.star,
      color: color,
      size: 24,
    );

    final Icon noPriorityIcon = Icon(
      Icons.star_border,
      color: color,
      size: 24,
    );

    // Text style on undone Task
    final TextStyle textStyleUndone =
        Theme.of(context).textTheme.bodyText2!.copyWith(
              // TODO: Add this font size to TextTheme ThemeData.
              fontSize: 15,
            );

    // Text style on done Task
    final TextStyle textStyleDone =
        Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 15,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 9),
      alignment: Alignment.center,
      child: Card(
        margin: const EdgeInsets.only(top: 9, bottom: 9),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(33.0),

          // TODO: Activate to named.
          onTap: () {
            _taskDetailScreenController.setTaskID(taskID);
            if (isMobileScreenSize(context)) {
              Navigator.pushNamed(context, RouteNames.taskDetail);
            }else{
              _homeScreenController.openTaskDetailScreen(true);
            }
          },
          child: Opacity(
            opacity: taskCompleted ? 0.6 : 1,
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 3, right: 3),
              leading: IconButton(
                  icon: taskCompleted ? doneIcon : undoneIcon,
                  onPressed: () => completedFunction()),
              title: Text(
                taskName,
                style: taskCompleted ? textStyleDone : textStyleUndone,
              ),
              trailing: IconButton(
                icon: taskPriority ? priorityIcon : noPriorityIcon,
                onPressed: () => priorityFunction(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
