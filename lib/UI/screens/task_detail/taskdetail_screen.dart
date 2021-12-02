import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/UI/screens/task_detail/widgets/taskdetail_task_title.dart';
import 'package:listzilla/domain/controllers/home/home_screen_controller.dart';
import 'package:listzilla/domain/controllers/task_detail/taskdetail_screen_controller.dart';
import 'package:listzilla/domain/controllers/task_detail/taskdetail_screen_state.dart';
import 'package:listzilla/domain/controllers/tasklist/tasklist_screen_controller.dart';

class TaskDetailScreen extends StatefulWidget {
  final DateTime noTime = DateTime.fromMillisecondsSinceEpoch(0);

  // TODO: Define controllers in stateful parent widget, not in State.
  final TaskDetailScreenController taskController =
      AppDependencies.dependencyInjector.resolve();
  final HomeScreenController homeScreenController =
      AppDependencies.dependencyInjector.resolve();
  final TaskListScreenController taskListScreenController =
      AppDependencies.dependencyInjector.resolve();

  TaskDetailScreen({Key? key}) : super(key: key);

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final TextEditingController taskDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    taskDescriptionController.addListener(() {
      widget.taskController.updateDescription(taskDescriptionController.text);
      taskDescriptionController.selection = TextSelection.fromPosition(
          TextPosition(offset: taskDescriptionController.text.length));
    });
  }

  /// Returns a bool that indicate if the app is running in a mobile screen size.
  bool isMobileScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width <= 1200;
  }

  @override
  void dispose() {
    taskDescriptionController.dispose();
    super.dispose();
  }

  // TODO: Add this to taskCards
  void togglePriority() {
    widget.taskController.toggleTaskPriority();
  }

  void toggleCompleted() {
    widget.taskController.toggleTaskCompleted();
  }

  void toggleMyDay() {
    widget.taskController.toggleTaskMyDay();

    widget.taskController.setExpirationDate(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      23,
      59,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeContext = Theme.of(context);
    final Color primaryColor = themeContext.colorScheme.primary;
    final Color detailsColor = themeContext.hintColor;

    final Icon dateIcon = Icon(
      Icons.query_builder,
      color: primaryColor,
      size: 27,
    );

    final Icon myDayIcon = Icon(
      Icons.flare_outlined,
      color: primaryColor,
      size: 27,
    );

    final Icon deleteIcon = Icon(
      Icons.delete_outline,
      color: detailsColor,
      size: 27,
    );

    return BlocConsumer<TaskDetailScreenController, TaskDetailScreenState>(
      bloc: widget.taskController,
      listener: (context, state) =>
          widget.taskListScreenController.getTaskListData(),
      builder: (context, state) {
        taskDescriptionController.text = state.taskDescription;
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            persistentFooterButtons: [
              // Buttons
              Container(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Created: ${getTextDate(state.taskCreationDate)}",
                        style: GoogleFonts.encodeSans(
                            fontSize: 15, color: detailsColor)),
                  ],
                ),
              ),
            ],
            appBar: AppBar(
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: IconButton(
                    icon: deleteIcon,
                    onPressed: () => deleteTask(),
                  ),
                )
              ],
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 24,
                ),
                onPressed: () {
                  if (!isMobileScreenSize(context)) {
                    widget.homeScreenController.openTaskDetailScreen(false);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
              title: Text(
                "Task Details",
                style: themeContext.textTheme.subtitle1,
              ),
            ),
            body: ListView(
              children: [
                // Task Title Section
                TaskDetailTitle(
                    taskName: state.taskName,
                    detailsColor: detailsColor,
                    taskPriority: state.taskPriority,
                    taskCompleted: state.taskCompleted,
                    completedFunction: () => toggleCompleted(),
                    primaryColor: primaryColor,
                    priorityFunction: () => togglePriority()),

                // Date Section
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Text(
                    "Date options:",
                    textAlign: TextAlign.center,
                    style: themeContext.textTheme.bodyText1,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Card(
                    margin: const EdgeInsets.only(top: 18, bottom: 9),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 21),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 24),
                                    child: myDayIcon),
                                Expanded(
                                  child: InkWell(
                                    onTap: () => toggleMyDay(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: detailsColor)),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: Text(
                                          state.taskMyDay
                                              ? "Added to my Day"
                                              : "Add to my day",
                                          style: themeContext
                                              .textTheme.bodyText2!
                                              .copyWith(
                                            color: state.taskMyDay
                                                ? primaryColor
                                                : detailsColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 24),
                                    child: dateIcon),
                                Expanded(
                                  child: InkWell(
                                    onTap: () => _pickDateTime(context),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: detailsColor)),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: Text(
                                          state.taskExpirationDate.compareTo(
                                                      widget.noTime) ==
                                                  0
                                              ? "Set expiration Date"
                                              : getTextDate(
                                                  state.taskExpirationDate),
                                          style: themeContext
                                              .textTheme.bodyText2!
                                              .copyWith(
                                                  color: state.taskExpirationDate
                                                              .compareTo(widget
                                                                  .noTime) ==
                                                          0
                                                      ? detailsColor
                                                      : primaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Note Section
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Text(
                    "Note:",
                    textAlign: TextAlign.center,
                    style: themeContext.textTheme.bodyText1,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Card(
                    margin: const EdgeInsets.only(top: 18, bottom: 9),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 21),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 300,
                            child: TextField(
                              maxLines: null,
                              style: themeContext.textTheme.bodyText2,
                              controller: taskDescriptionController,
                              decoration: InputDecoration(
                                hintStyle: themeContext.textTheme.bodyText2!
                                    .copyWith(color: Colors.grey),
                                counterStyle: themeContext.textTheme.bodyText2!
                                    .copyWith(color: Colors.grey),
                                focusedBorder: InputBorder.none,
                                hintText: 'Add a description',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2033));

    if (pickedDate != null) {
      final TimeOfDay? pickedHour = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedHour != null) {
        final DateTime newTaskDate = DateTime(pickedDate.year, pickedDate.month,
            pickedDate.day, pickedHour.hour, pickedHour.minute);

        if (newTaskDate.year == DateTime.now().year &&
            newTaskDate.month == DateTime.now().month &&
            newTaskDate.day == DateTime.now().day) {
          widget.taskController.toggleTaskMyDay();
        }

        widget.taskController.setExpirationDate(newTaskDate);
      }
    }
  }

  String getTextDate(DateTime date) {
    return DateFormat.yMd().add_jm().format(date);
  }

  void deleteTask() async {
    // TODO: Extract Dialogs
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Delete task",
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          content: Text(
            "Are you sure want to delete this task?",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    ).then((delete) {
      if (delete) {
        widget.taskController.deleteTask();
        widget.taskListScreenController
            .setTaskListID(widget.taskListScreenController.state.taskListID);
        if (isMobileScreenSize(context)) {
          Navigator.of(context).pop();
        } else {
          widget.homeScreenController.openTaskDetailScreen(false);
        }
      }
    });
  }
}
