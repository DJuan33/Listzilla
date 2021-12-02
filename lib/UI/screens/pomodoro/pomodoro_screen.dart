import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/UI/screens/pomodoro/widgets/pomodoro_topbar.dart';
import 'package:listzilla/domain/controllers/home/home_screen_controller.dart';
import 'package:listzilla/domain/controllers/pomodoro/pomodoro_screen_controller.dart';
import 'package:listzilla/domain/controllers/pomodoro/pomodoro_screen_state.dart';
import 'package:listzilla/main.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({Key? key}) : super(key: key);

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  final PomodoroScreenController _pomodoroScreenController =
      AppDependencies.dependencyInjector.resolve();

  final HomeScreenController _homeScreenController = AppDependencies.dependencyInjector.resolve();

  Duration countdownDuration = const Duration(seconds: 5);
  Duration currentDuration = const Duration();
  Timer? timer;

  void showCompletedNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        // TODO: Add strings to AppConstants.
        AndroidNotificationDetails(
      'LISTZILLA_POMODORO',
      'Listzilla',
      channelDescription: 'Listzilla App notification channel',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'Listzilla',
        pomodoroMessage(_pomodoroScreenController.getPomodoroMode()),
        platformChannelSpecifics,
        payload: 'item x');
  }

  @override
  void initState() {
    super.initState();
    _pomodoroScreenController.onInit();
    _pomodoroScreenController.getWeekFocusedTime();
    countdownDuration = _pomodoroScreenController.getPomodoroModeDuration();
    currentDuration = countdownDuration;
  }

  String pomodoroMessage(int pomodoroMode) {
    String pomodoroNotificationMessage = "";

    switch (pomodoroMode) {
      case 0:
        {
          pomodoroNotificationMessage = "Pomodoro completed";
          break;
        }
      default:
        {
          pomodoroNotificationMessage = "Break completed";
        }
    }

    return pomodoroNotificationMessage;
  }

  void reset() {
    setState(() {
      countdownDuration = _pomodoroScreenController.getPomodoroModeDuration();
      currentDuration = countdownDuration;
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    const addSeconds = -1;
    setState(() {
      final seconds = currentDuration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
        if (defaultTargetPlatform == TargetPlatform.android) {
          showCompletedNotification();
        }
        _pomodoroScreenController.addTimerComplete();
        showTimerCompleteDialog();
      } else {
        currentDuration = Duration(seconds: seconds);
      }
    });
  }

  void showTimerCompleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Timer Complete",
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          content: Text(
            _pomodoroScreenController.state.pomodoroMode != 0
                ? "Pomodoro completed"
                : "Break completed",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _homeScreenController.setTabIndex(3);
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    ).then((value) {
      setState(() {
        countdownDuration = _pomodoroScreenController.getPomodoroModeDuration();
        currentDuration = _pomodoroScreenController.getPomodoroModeDuration();
      });
    });
  }

  void stopTimer({bool resetTimer = true}) {
    if (resetTimer) {
      _pomodoroScreenController.addTimerComplete();
      showTimerCompleteDialog();
      reset();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);
    return BlocConsumer<PomodoroScreenController, PomodoroScreenState>(
      listener: (context, state) {
        setState(() {
          countdownDuration =
              _pomodoroScreenController.getPomodoroModeDuration();
          currentDuration = countdownDuration;
        });
      },
      bloc: _pomodoroScreenController,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PomodoroTopBar(
              setPomodoroLengthCallback:
                  _pomodoroScreenController.setPomodorosLength,
              setPomodoroLongBreakCallback:
                  _pomodoroScreenController.setPomodoroLongBreakLength,
              setPomodoroShortBreakCallback:
                  _pomodoroScreenController.setPomodoroShortBreakLength,
            ),
            // TODO: Extract this Widget.
            Container(
              margin: const EdgeInsets.symmetric(vertical: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: buildTimer(
                      themeContext,
                      state.pomodorosForBreak,
                      state.currentPomodoro,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 9),
              child: buildTimerButtons(),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 1200),
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  pomodoroData("Pomodoros for long break:",
                      "${state.currentPomodoro} / ${state.pomodorosForBreak}"),
                  pomodoroData("Time focused this week:",
                      "${state.focusedTimeThisWeek} min"),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget buildTimer(
    ThemeData themeContext,
    int totalPomodoros,
    int currentPomodoros,
  ) =>
      Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: currentDuration.inSeconds / countdownDuration.inSeconds,
            valueColor:
                AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
            strokeWidth: 9,
            backgroundColor: Colors.grey,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTime(),
              ],
            ),
          ),
        ],
      );

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = twoDigits(currentDuration.inMinutes.remainder(60));
    final seconds = twoDigits(currentDuration.inSeconds.remainder(60));

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTimeStamp(
              text: minutes,
            ),
            buildTimeStamp(
              text: ":",
            ),
            buildTimeStamp(
              text: seconds,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildTimeStamp({required String text}) => Padding(
        padding: const EdgeInsets.all(9.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 50,
              ),
        ),
      );

  Widget buildTimerButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = currentDuration.inSeconds == 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        isRunning || isCompleted
            ? ElevatedButton(
                child: Text(
                  "STOP",
                  style: Theme.of(context).textTheme.button!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                onPressed: () {
                  if (isRunning) {
                    stopTimer(resetTimer: false);
                  }
                },
              )
            : ElevatedButton(
                child: Text(
                  "START",
                  style: Theme.of(context).textTheme.button!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                onPressed: () => startTimer()),
        // TODO: Add margin instead using SizedBox
        const SizedBox(
          width: 12,
        ),
        ElevatedButton(
          child: Text(
            "SKIP",
            style: Theme.of(context).textTheme.button!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          onPressed: () => stopTimer(),
        ),
      ],
    );
  }

  Widget pomodoroData(String title, String data) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 21,
      ),
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              // TODO: Text align center.
              style: Theme.of(context).textTheme.bodyText1),
          Text(
            data,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
