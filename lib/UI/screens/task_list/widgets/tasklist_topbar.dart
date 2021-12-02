import 'package:flutter/material.dart';

class TaskListTopbar extends StatelessWidget {
  final String taskListName;
  final String? taskListEmoji;
  final VoidCallback orderByPriorityFunction;
  final VoidCallback orderByDateFunction;
  final VoidCallback deleteTaskListFunction;
  final bool deleteableList;

  const TaskListTopbar({Key? key, 
    required this.taskListName,
    this.taskListEmoji,
    required this.orderByPriorityFunction,
    required this.orderByDateFunction,
    required this.deleteTaskListFunction,
    this.deleteableList = true,
  }) : super(key: key);

  /// Returns a bool that indicate if the app is running in a mobile screen size.
  bool isMobileScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width <= 1200;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: isMobileScreenSize(context),
      title: Text("$taskListEmoji   $taskListName"),
      actions: [
        PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case TaskListOptions.orderPriority:
                  {
                    orderByPriorityFunction();
                    break;
                  }
                case TaskListOptions.orderDate:
                  {
                    orderByDateFunction();
                    break;
                  }

                case TaskListOptions.deleteList:
                  {
                    deleteTaskListFunction();
                    break;
                  }
              }
            },
            itemBuilder: (context) => <PopupMenuEntry<TaskListOptions>>[
                  PopupMenuItem<TaskListOptions>(
                    value: TaskListOptions.orderDate,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.list_alt_outlined,
                            color: themeContext.colorScheme.primary,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Order by Date",
                            textAlign: TextAlign.start,
                            style: themeContext.textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<TaskListOptions>(
                    value: TaskListOptions.orderPriority,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.star,
                            color: themeContext.colorScheme.primary,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Order by Priority",
                            textAlign: TextAlign.start,
                            style: themeContext.textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if(deleteableList)
                  PopupMenuItem<TaskListOptions>(
                    value: TaskListOptions.deleteList,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.delete_outline,
                            color: themeContext.colorScheme.primary,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Delete List",
                            textAlign: TextAlign.start,
                            style: themeContext.textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
            icon: const Icon(
              Icons.more_vert,
            ),
            padding: const EdgeInsets.all(0)),
      ],
    );
  }
}

enum TaskListOptions {
  orderDate,
  orderPriority,
  deleteList,
}
