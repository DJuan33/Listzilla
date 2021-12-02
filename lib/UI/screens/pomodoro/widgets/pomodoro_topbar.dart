import 'package:flutter/material.dart';
import 'package:listzilla/UI/screens/pomodoro/widgets/dialogs/pomodoro_select_pomodoro_length.dart';

class PomodoroTopBar extends StatelessWidget {
  final Function(int) setPomodoroLengthCallback;
  final Function(int) setPomodoroShortBreakCallback;
  final Function(int) setPomodoroLongBreakCallback;
  const PomodoroTopBar({
    Key? key,
    required this.setPomodoroLengthCallback,
    required this.setPomodoroLongBreakCallback,
    required this.setPomodoroShortBreakCallback,
  }) : super(key: key);

  void pomodoroDurationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const PomodoroLengthDialog(
            dialogTitle: "Pick Pomodoro Duration");
      },
    ).then((duration) {
      if (duration != -1) {
        setPomodoroLengthCallback(duration);
      }
    });
  }

  void pomodoroShortBreakDurationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const PomodoroLengthDialog(
            dialogTitle: "Pick Pomodoro Short Break Duration");
      },
    ).then((duration) {
      if (duration != -1) {
        setPomodoroShortBreakCallback(duration);
      }
    });
  }

  void pomodoroLongBreakDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const PomodoroLengthDialog(
            dialogTitle: "Pick Pomodoro Long Break Duration");
      },
    ).then((duration) {
      if (duration != -1) {
        setPomodoroLongBreakCallback(duration);
      }
    });
  }

  /// Returns a bool that indicate if the app is running in a mobile screen size.
  bool isMobileScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width <= 1200;
  }
  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);

    // TODO: Extract app bar as a Global Widget.
    return AppBar(
      automaticallyImplyLeading: isMobileScreenSize(context),
      title: const Text("Pomodoro"),
      actions: [
        PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case PomodoroOptions.durationPomodoro:
                  {
                    pomodoroDurationDialog(context);
                    break;
                  }
                case PomodoroOptions.durationShortBreak:
                  {
                    pomodoroShortBreakDurationDialog(context);
                    break;
                  }

                case PomodoroOptions.durationLongBreak:
                  {
                    pomodoroShortBreakDurationDialog(context);
                    break;
                  }
              }
            },
            itemBuilder: (context) => <PopupMenuEntry<PomodoroOptions>>[
                  PopupMenuItem<PomodoroOptions>(
                    value: PomodoroOptions.durationPomodoro,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.timer,
                            color: themeContext.colorScheme.primary,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Set pomodoro duration",
                            textAlign: TextAlign.start,
                            style: themeContext.textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<PomodoroOptions>(
                    value: PomodoroOptions.durationLongBreak,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.bedtime,
                            color: themeContext.colorScheme.primary,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Set long break duration",
                            textAlign: TextAlign.start,
                            style: themeContext.textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<PomodoroOptions>(
                    value: PomodoroOptions.durationShortBreak,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.timelapse,
                            color: themeContext.colorScheme.primary,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Set short break duration",
                            textAlign: TextAlign.start,
                            style: themeContext.textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
            icon: const Icon(
              Icons.more_vert,
            ),
            padding: const EdgeInsets.all(0)),
      ],
    );
  }
}

enum PomodoroOptions {
  durationPomodoro,
  durationShortBreak,
  durationLongBreak
}
