import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/domain/controllers/calendar/calendar_screen_state.dart';
import 'package:listzilla/domain/models/task_model.dart';
import 'package:listzilla/domain/repositories/task_repository.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreenController extends Cubit<CalendarScreenState> {
  final TaskRepositoryInterface taskDBConnection;

  CalendarScreenController({required this.taskDBConnection})
      : super(CalendarScreenState.initial);

  void setDays(DateTime selectedDay, DateTime focusedDay) {
    emit(state.copyWith(
      selectedDay: selectedDay,
      focusedDay: focusedDay,
    ));
    setEvents();
  }

  CalendarFormat getCalendarFormat() {
    return state.calendarFormat == 0
        ? CalendarFormat.month
        : CalendarFormat.week;
  }

  void setCalendarFormat(int calendarFormat) {
    emit(state.copyWith(
      calendarFormat: calendarFormat,
    ));
  }

  void setEvents() {
    Map<DateTime, List<Task>> taskEvents = {};
    taskEvents = taskDBConnection.getTasksByDate();
    emit(state.copyWith(taskEvents: taskEvents));
  }

  List<Task> getEventsForSelectedDay(DateTime day) {
    return state.taskEvents[day] ?? [];
  }
}
