import 'package:hive/hive.dart';
import 'package:listzilla/domain/models/user_model.dart';
import 'package:listzilla/domain/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

class UserRepositoryHive extends UserRepositoryInterface {
  Box<User> userBox = Hive.box('USER');

  @override
  Future<String> createNewUser() async {
    String newUserID = const Uuid().v4();
    bool newDataAdded = false;

    User newUser = User(
      id: newUserID,
      groupListsID: [],
      themeMode: 0,
      dataAdded: newDataAdded,
      pomodorosID: [],
      pomodoroLongBreakLength: 20,
      pomodoroShortBreakLength: 5,
      pomodorosLength: 25,
      pomodorosToBreak: 4,
      calendarWeekFirstDay: 1,
    );

    await userBox.add(newUser);
    return newUserID;
  }

  @override
  int getUserPomodorosLength() => userBox.values.elementAt(0).pomodorosLength;

  @override
  int getUserPomodorosLongBreakLength() =>
      userBox.values.elementAt(0).pomodoroLongBreakLength;

  @override
  int getUserPomodorosShortBreakLength() =>
      userBox.values.elementAt(0).pomodoroShortBreakLength;

  @override
  int getUserPomodorosToBreak() => userBox.values.elementAt(0).pomodorosToBreak;

  @override
  int getUserThemeMode() => userBox.values.elementAt(0).themeMode;

  @override
  bool isDataAdded(String userID) {
    User user = userBox.values.elementAt(0);
    bool isDataAdded = false;

    isDataAdded = user.dataAdded;

    return isDataAdded;
  }

  @override
  void setDataAdded() {
    User? user = userBox.values.elementAt(0);

    userBox.delete(user.id);
    User userUpdated = User(
      dataAdded: true,
      themeMode: user.themeMode,
      id: user.id,
      groupListsID: user.groupListsID,
      pomodorosID: [],
      pomodoroLongBreakLength: user.pomodoroLongBreakLength,
      pomodoroShortBreakLength: user.pomodoroShortBreakLength,
      pomodorosLength: user.pomodorosLength,
      pomodorosToBreak: user.pomodorosToBreak,
      calendarWeekFirstDay: user.calendarWeekFirstDay,
    );

    userBox.putAt(0, userUpdated);
  }

  @override
  void setPomodoroLongBreak(int durationInMinutes) {
    User? user = userBox.values.elementAt(0);

    User userUpdated = User(
      dataAdded: user.dataAdded,
      themeMode: user.themeMode,
      id: user.id,
      groupListsID: user.groupListsID,
      pomodorosID: user.pomodorosID,
      pomodoroLongBreakLength: durationInMinutes,
      pomodoroShortBreakLength: user.pomodoroShortBreakLength,
      pomodorosLength: user.pomodorosLength,
      pomodorosToBreak: user.pomodorosToBreak,
      calendarWeekFirstDay: user.calendarWeekFirstDay,
    );

    userBox.putAt(0, userUpdated);
  }

  @override
  void setPomodoroShortBreak(int durationInMinutes) {
    User? user = userBox.values.elementAt(0);
    
    userBox.delete(user.id);

    User userUpdated = User(
      dataAdded: user.dataAdded,
      themeMode: user.themeMode,
      id: user.id,
      groupListsID: user.groupListsID,
      pomodorosID: user.pomodorosID,
      pomodoroLongBreakLength: user.pomodoroLongBreakLength,
      pomodoroShortBreakLength: durationInMinutes,
      pomodorosLength: user.pomodorosLength,
      pomodorosToBreak: user.pomodorosToBreak,
      calendarWeekFirstDay: user.calendarWeekFirstDay,
    );

    userBox.putAt(0, userUpdated);
  }

  @override
  void setPomodorosLength(int durationInMinutes) {
    User? user = userBox.values.elementAt(0);

    userBox.delete(user.id);

    User userUpdated = User(
      dataAdded: user.dataAdded,
      themeMode: user.themeMode,
      id: user.id,
      groupListsID: user.groupListsID,
      pomodorosID: user.pomodorosID,
      pomodoroLongBreakLength: user.pomodoroLongBreakLength,
      pomodoroShortBreakLength: user.pomodoroShortBreakLength,
      pomodorosLength: durationInMinutes,
      pomodorosToBreak: user.pomodorosToBreak,
      calendarWeekFirstDay: user.calendarWeekFirstDay,
    );

    userBox.putAt(0, userUpdated);
  }


  @override
  void setThemeMode(int themeMode) {
    User? user = userBox.values.elementAt(0);

    userBox.delete(user.id);
    User userUpdated = User(
      dataAdded: user.dataAdded,
      id: user.id,
      themeMode: themeMode,
      groupListsID: user.groupListsID,
      pomodorosID: user.pomodorosID,
      pomodoroLongBreakLength: user.pomodoroLongBreakLength,
      pomodoroShortBreakLength: user.pomodoroShortBreakLength,
      pomodorosLength: user.pomodorosLength,
      pomodorosToBreak: user.pomodorosToBreak,
      calendarWeekFirstDay: user.calendarWeekFirstDay,
    );

    userBox.putAt(0, userUpdated);
  }

  @override
  bool userExists() {
    return userBox.isNotEmpty;
  }
}
