import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/UI/global_widgets/task_card.dart';
import 'package:listzilla/UI/screens/calendar/widgets/calendar_topbar.dart';
import 'package:listzilla/domain/controllers/calendar/calendar_screen_controller.dart';
import 'package:listzilla/domain/controllers/calendar/calendar_screen_state.dart';
import 'package:listzilla/domain/controllers/task_detail/taskdetail_screen_controller.dart';
import 'package:listzilla/domain/controllers/task_detail/taskdetail_screen_state.dart';
import 'package:listzilla/domain/controllers/tasklist/tasklist_screen_controller.dart';
import 'package:listzilla/domain/controllers/tasklist/tasklist_screen_state.dart';
import 'package:listzilla/domain/models/task_model.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  final StartingDayOfWeek _startingDayOfWeek = StartingDayOfWeek.monday;

  final CalendarScreenController _calendarScreenController =
      AppDependencies.dependencyInjector.resolve();

  final TaskListScreenController _taskListScreenController =
      AppDependencies.dependencyInjector.resolve();

  final TaskDetailScreenController _taskDetailScreenController =
      AppDependencies.dependencyInjector.resolve();

  final DateFormat formatter = DateFormat('EEEE, dd of MMMM:');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _calendarScreenController.setEvents());
  }

  void _onDaySelected(
      DateTime selectedDay, DateTime focusedDay, DateTime currentSelectedDay) {
    if (!isSameDay(currentSelectedDay, selectedDay)) {
      _calendarScreenController.setDays(selectedDay, focusedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<TaskDetailScreenController, TaskDetailScreenState>(
          bloc: _taskDetailScreenController,
          listenWhen: (previousState, state) {
            return previousState.taskExpirationDate != state.taskExpirationDate
                ? true
                : false;
          },
          listener: (context, state) {
            _calendarScreenController.setEvents();
          },
        ),
        BlocListener<TaskListScreenController, TaskListScreenState>(
          bloc: _taskListScreenController,
          listener: (context, state) {
            _calendarScreenController.setEvents();
          },
        ),
      ],
      child: BlocBuilder<CalendarScreenController, CalendarScreenState>(
        bloc: _calendarScreenController,
        builder: (context, state) {
          _calendarFormat = _calendarScreenController.getCalendarFormat();
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                CalendarTopBar(calendarFormatCallback: _calendarScreenController.setCalendarFormat),
                Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: TableCalendar(
                    selectedDayPredicate: (day) => state.selectedDay == day,
                    onDaySelected: (selectedDay, focusedDay) {
                      _onDaySelected(selectedDay, focusedDay, state.selectedDay);
                    },
                    firstDay: DateTime(1998),
                    focusedDay: state.focusedDay,
                    lastDay: DateTime.now().add(const Duration(days: 333)),
                    calendarFormat: _calendarFormat,
                    startingDayOfWeek: _startingDayOfWeek,
                    daysOfWeekHeight: 33,
                    eventLoader: _calendarScreenController.getEventsForSelectedDay,
                    calendarStyle: CalendarStyle(
                      markersMaxCount: 1,
                      markerSizeScale: 0.3,
                      cellMargin: const EdgeInsets.symmetric(vertical: 9, horizontal: 9),
                      markerMargin: const EdgeInsets.only(top: 3),
                      markerDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: themeContext.scaffoldBackgroundColor,
                        ),
                      ),
                      isTodayHighlighted: true,
                      selectedDecoration: BoxDecoration(
                        color: themeContext.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: themeContext.textTheme.bodyText2!,
                      selectedTextStyle: themeContext.textTheme.bodyText2!.copyWith(
                        color: themeContext.scaffoldBackgroundColor,
                      ),
                      todayDecoration: BoxDecoration(
                        color: themeContext.scaffoldBackgroundColor,
                        border: Border.all(color: themeContext.colorScheme.primary),
                        shape: BoxShape.circle,
                      ),
                    ),
                    headerStyle: const HeaderStyle(formatButtonVisible: false),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Tasks for ${formatter.format(state.selectedDay)}",
                    style: themeContext.textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: _buildTaskCards(
                    _calendarScreenController
                        .getEventsForSelectedDay(state.selectedDay),
                    themeContext,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void togglePriority(String taskID) {
    _taskListScreenController.toggleTaskPriority(taskID);
    _calendarScreenController.setEvents();
  }

  void toggleCompleted(String taskID) {
    _taskListScreenController.toggleTaskCompleted(taskID);
  }

  Widget _buildTaskCards(List<Task?> taskEvents, ThemeData themeContext) {
    return taskEvents.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: taskEvents.length,
            itemBuilder: (context, index) {
              Task? task = taskEvents[index];
              
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
            })
        : Center(
            child: Container(
              margin: const EdgeInsets.only(top: 6, bottom: 6),
              padding: const EdgeInsets.symmetric(vertical: 90),
              child: DottedBorder(
                color: Colors.grey,
                radius: const Radius.circular(100),
                strokeWidth: 1,
                dashPattern: const [3, 2],
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 21),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                          size: 33,
                        ),
                      ),
                      Text(
                        "No tasks for this day",
                        style: themeContext.textTheme.bodyText2!.copyWith(
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
