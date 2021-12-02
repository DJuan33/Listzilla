import 'package:listzilla/domain/models/pomodoro_model.dart';

abstract class PomodoroRepositoryInterface{
  List<Pomodoro?> getPomodoroRangeDate();
  void addPomodoro(Pomodoro pomodoro);
  void newPomodoro(int lengthInSeconds, DateTime dateCompleted, String? taskID);
  Pomodoro? getPomodoro(String pomodoroID);
}
