import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/domain/controllers/pomodoro/pomodoro_screen_state.dart';
import 'package:listzilla/domain/models/pomodoro_model.dart';
import 'package:listzilla/domain/repositories/pomodoro_repository.dart';
import 'package:listzilla/domain/repositories/user_repository.dart';

class PomodoroScreenController extends Cubit<PomodoroScreenState> {
  final PomodoroRepositoryInterface pomodoroDBConnection;
  final UserRepositoryInterface userDBConnection;

  PomodoroScreenController({
    required this.pomodoroDBConnection,
    required this.userDBConnection,
  }) : super(PomodoroScreenState.initial);

  void getWeekFocusedTime() {
    int focusedTime = 0;

    List<Pomodoro?> weekPomodoros = pomodoroDBConnection.getPomodoroRangeDate();

    for (var x in weekPomodoros) {
      if (x != null) {
        focusedTime += Duration(seconds: x.lengthInSeconds).inMinutes;
      }
    }

    emit(
      state.copyWith(focusedTimeThisWeek: focusedTime),
    );
  }

  void onInit() {
    Duration userPomodoroDuration =
        Duration(minutes: userDBConnection.getUserPomodorosLength());
    Duration userPomodoroShortBreakDuration =
        Duration(minutes: userDBConnection.getUserPomodorosShortBreakLength());
    Duration userPomodoroLongBreakDuration =
        Duration(minutes: userDBConnection.getUserPomodorosLongBreakLength());
    int userPomodorosToBreak = userDBConnection.getUserPomodorosToBreak();

    emit(state.copyWith(
      pomodoroDuration: userPomodoroDuration,
      longBreakDuration: userPomodoroLongBreakDuration,
      shortBreakDuration: userPomodoroShortBreakDuration,
      pomodorosForBreak: userPomodorosToBreak,
    ));
  }

  void addTimerComplete() {
    int pomodoroCount = state.currentPomodoro;

    switch (state.pomodoroMode) {
      case 0:
        {
          pomodoroDBConnection.newPomodoro(state.pomodoroDuration.inSeconds,
              DateTime.now(), state.selectedTaskID);
          pomodoroCount++;
          if (pomodoroCount == state.pomodorosForBreak) {
            emit(
              state.copyWith(
                pomodoroMode: 2,
                currentPomodoro: pomodoroCount,
                focusedTimeThisWeek: state.focusedTimeThisWeek +
                    state.pomodoroDuration.inMinutes,
              ),
            );
          } else {
            emit(
              state.copyWith(
                pomodoroMode: 1,
                currentPomodoro: pomodoroCount,
                focusedTimeThisWeek: state.focusedTimeThisWeek +
                    state.pomodoroDuration.inMinutes,
              ),
            );
          }
          break;
        }

      case 2:
        {
          emit(
            state.copyWith(
              pomodoroMode: 0,
              currentPomodoro: 0,
            ),
          );
          break;
        }

      default:
        {
          emit(
            state.copyWith(
              pomodoroMode: 0,
            ),
          );
          break;
        }
    }
  }

  void setPomodorosLength(int durationInMinutes) {
    userDBConnection.setPomodorosLength(durationInMinutes);
    emit(
      state.copyWith(pomodoroDuration: Duration(minutes: durationInMinutes)),
    );
  }

  void setPomodoroShortBreakLength(int durationInMinutes) {
    userDBConnection.setPomodoroLongBreak(durationInMinutes);
    emit(
      state.copyWith(shortBreakDuration: Duration(minutes: durationInMinutes)),
    );
  }

  void setPomodoroLongBreakLength(int durationInMinutes) {
    userDBConnection.setPomodoroLongBreak(durationInMinutes);
    emit(
      state.copyWith(longBreakDuration: Duration(minutes: durationInMinutes)),
    );
  }
  
  /// Returns the current mode of the pomodoro timer.
  int getPomodoroMode(){
      return state.pomodoroMode;
  }

  /// Returns a Duration that depends on the current pomodoro mode.
  Duration getPomodoroModeDuration() {
    Duration pomodoroDuration = const Duration(seconds: 0);

    switch (state.pomodoroMode) {
      case 0:
        {
          pomodoroDuration = state.pomodoroDuration;
          break;
        }

      case 1:
        {
          pomodoroDuration = state.shortBreakDuration;
          break;
        }
      case 2:
        {
          pomodoroDuration = state.longBreakDuration;
          break;
        }
    }

    return pomodoroDuration;
  }
}
