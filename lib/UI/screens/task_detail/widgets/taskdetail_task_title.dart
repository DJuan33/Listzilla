import 'package:flutter/material.dart';

class TaskDetailTitle extends StatelessWidget {
  final String taskName;
  final Color primaryColor;
  final Color detailsColor;
  final bool taskCompleted;
  final bool taskPriority;
  final Function completedFunction;
  final Function priorityFunction;

  const TaskDetailTitle(
      {Key? key, required this.taskName,
      required this.primaryColor,
      required this.detailsColor,
      required this.taskCompleted,
      required this.taskPriority,
      required this.completedFunction,
      required this.priorityFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeContext = Theme.of(context);
    // Text style on undone Task
    final TextStyle textStyleUndone =
        themeContext.textTheme.subtitle1!.copyWith(
      fontSize: 21,
      fontWeight: FontWeight.w600,
    );

    // Text style on done Task
    final TextStyle textStyleDone = textStyleUndone.copyWith(
      color: Colors.grey,
      decoration: TextDecoration.lineThrough,
    );

    final Icon priorityIcon = Icon(
      Icons.star,
      color: primaryColor,
      size: 27,
    );

    final Icon noPriorityIcon = Icon(
      Icons.star_border,
      color: primaryColor,
      size: 27,
    );

    final Icon uncompletedIcon = Icon(
      Icons.radio_button_unchecked,
      color: primaryColor,
      size: 27,
    );

    final Icon completedIcon = Icon(
      Icons.check_circle,
      color: primaryColor,
      size: 27,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        margin: const EdgeInsets.only(top: 18, bottom: 9),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: taskCompleted ? completedIcon : uncompletedIcon,
                  onPressed: () => completedFunction()),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 9),
                  child: Text(
                    taskName,
                    textAlign: TextAlign.left,
                    style: taskCompleted ? textStyleDone : textStyleUndone,
                  ),
                ),
              ),
              IconButton(
                  icon: taskPriority ? priorityIcon : noPriorityIcon,
                  onPressed: () => priorityFunction())
            ],
          ),
        ),
      ),
    );
  }
}
