import 'package:equatable/equatable.dart';

class PomodoroScreenState extends Equatable {
  final Duration pomodoroDuration;
  final Duration longBreakDuration;
  final Duration shortBreakDuration;
  final int currentPomodoro;
  final int pomodorosForBreak;
  final String selectedTaskID;
  final int focusedTimeThisWeek;

  /// 0 for pomodoro, 1 for short break, 2 for long break.
  final int pomodoroMode;

  const PomodoroScreenState({
    required this.pomodoroDuration,
    required this.longBreakDuration,
    required this.shortBreakDuration,
    required this.currentPomodoro,
    required this.pomodorosForBreak,
    required this.pomodoroMode,
    required this.selectedTaskID,
    required this.focusedTimeThisWeek,
  });

  static PomodoroScreenState initial = const PomodoroScreenState(
    pomodoroDuration: Duration(minutes: 1),
    longBreakDuration: Duration(seconds: 12),
    shortBreakDuration: Duration(seconds: 6),
    currentPomodoro: 0,
    pomodorosForBreak: 4,
    pomodoroMode: 0,
    selectedTaskID: "",
    focusedTimeThisWeek: 0,
  );

  PomodoroScreenState copyWith({
    Duration? pomodoroDuration,
    Duration? longBreakDuration,
    Duration? shortBreakDuration,
    int? currentPomodoro,
    int? pomodorosForBreak,
    int? pomodoroMode,
    String? selectedTaskID,
    int? focusedTimeThisWeek,
  }) {
    return PomodoroScreenState(
      pomodoroDuration: pomodoroDuration ?? this.pomodoroDuration,
      longBreakDuration: longBreakDuration ?? this.longBreakDuration,
      shortBreakDuration: shortBreakDuration ?? this.shortBreakDuration,
      currentPomodoro: currentPomodoro ?? this.currentPomodoro,
      pomodorosForBreak: pomodorosForBreak ?? this.pomodorosForBreak,
      pomodoroMode: pomodoroMode ?? this.pomodoroMode,
      selectedTaskID: selectedTaskID ?? this.selectedTaskID,
      focusedTimeThisWeek: focusedTimeThisWeek ?? this.focusedTimeThisWeek,
    );
  }

  @override
  List<Object?> get props => [
        pomodoroDuration,
        longBreakDuration,
        shortBreakDuration,
        currentPomodoro,
        pomodoroDuration,
        pomodoroMode,
        selectedTaskID,
        focusedTimeThisWeek,
      ];
}
