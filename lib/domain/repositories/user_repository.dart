abstract class UserRepositoryInterface {
  Future<String> createNewUser();
  int getUserPomodorosLength();
  int getUserPomodorosLongBreakLength();
  int getUserPomodorosShortBreakLength();
  int getUserPomodorosToBreak();
  int getUserThemeMode();
  bool isDataAdded(String userID);
  void setDataAdded();
  void setThemeMode(int themeMode);
  bool userExists();
  void setPomodoroShortBreak(int durationInMinutes);
  void setPomodoroLongBreak(int durationInMinutes);
  void setPomodorosLength(int durationInMinutes);
}
