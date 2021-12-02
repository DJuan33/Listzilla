import 'package:equatable/equatable.dart';
import 'package:listzilla/domain/models/task_model.dart';

class CalendarScreenState extends Equatable {
  final Map<DateTime, List<Task>> taskEvents;
  final DateTime selectedDay;
  final DateTime focusedDay;

  /// The code for the calendar format.
  ///
  /// 0 for month, 1 for week.
  final int calendarFormat;

  const CalendarScreenState({
    required this.taskEvents,
    required this.selectedDay,
    required this.focusedDay,
    required this.calendarFormat,
  });

  CalendarScreenState copyWith({
    Map<DateTime, List<Task>>? taskEvents,
    DateTime? selectedDay,
    DateTime? focusedDay,
    int? calendarFormat,
  }) {
    return CalendarScreenState(
      taskEvents: taskEvents ?? this.taskEvents,
      selectedDay: selectedDay ?? this.selectedDay,
      focusedDay: focusedDay ?? this.focusedDay,
      calendarFormat: calendarFormat ?? this.calendarFormat,
    );
  }

  static CalendarScreenState initial = CalendarScreenState(
    taskEvents: const {},
    selectedDay: DateTime.fromMillisecondsSinceEpoch(0),
    focusedDay: DateTime.now(),
    calendarFormat: 0,
  );

  @override
  List<Object?> get props => [
        taskEvents,
        selectedDay,
        focusedDay,
        calendarFormat,
      ];
}
