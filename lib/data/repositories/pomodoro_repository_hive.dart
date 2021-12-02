import 'package:hive/hive.dart';
import 'package:listzilla/domain/models/pomodoro_model.dart';
import 'package:listzilla/domain/repositories/pomodoro_repository.dart';
import 'package:uuid/uuid.dart';

class PomodoroRepositoryHive implements PomodoroRepositoryInterface {
  Box<Pomodoro> pomodoroBox = Hive.box('POMODORO');
  @override
  void addPomodoro(Pomodoro pomodoro) {
    pomodoroBox.put(pomodoro.id, pomodoro);
  }

  @override
  List<Pomodoro?> getPomodoroRangeDate() {
    List<Pomodoro?> weekPomodoros = [];

    DateTime mostRecentMonday = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day - (DateTime.now().weekday - 1));

    Iterable<dynamic> pomodoros = pomodoroBox.keys;

    for (var x in pomodoros) {
      Pomodoro? finded = getPomodoro(x);
      if (finded != null) {
        if (finded.dateCompleted.isAfter(mostRecentMonday) &&
            finded.dateCompleted.isBefore(DateTime.now())) {
          weekPomodoros.add(finded);
        }
      }
    }

    return weekPomodoros;
  }

  @override
  Pomodoro? getPomodoro(String pomodoroID) {
    Pomodoro? pomodoroFinded = pomodoroBox.get(pomodoroID);
    return pomodoroFinded;
  }

  @override
  void newPomodoro(
      int lengthInSeconds, DateTime dateCompleted, String? taskID) {
    String newPomodoroID = const Uuid().v4();

    Pomodoro newPomodoro = Pomodoro(
      id: newPomodoroID,
      dateCompleted: dateCompleted,
      lengthInSeconds: lengthInSeconds,
      taskID: taskID ?? "",
    );

    addPomodoro(newPomodoro);
  }
}
