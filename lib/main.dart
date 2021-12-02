import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/UI/screens/home/home_screen.dart';
import 'package:listzilla/domain/models/group_list_model.dart';
import 'package:listzilla/domain/models/pomodoro_model.dart';
import 'package:listzilla/domain/models/task_list_model.dart';
import 'package:listzilla/domain/models/task_model.dart';
import 'package:listzilla/domain/models/user_model.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  // Ensure Widget binding is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Start Hive.
  await Hive.initFlutter();

  if (defaultTargetPlatform == TargetPlatform.android) {
// Initialize Notifications Plugin.
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('notification_icon');
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint("Notification Payload: $payload");
      }
    });
  }

  // Register Hive adapters.
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskListAdapter());
  Hive.registerAdapter(GroupListAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(PomodoroAdapter());

  // Open Hive Boxes
  await Hive.openBox<Task>('TASK');
  await Hive.openBox<TaskList>('LIST');
  await Hive.openBox<GroupList>('GROUP');
  await Hive.openBox<User>('USER');
  await Hive.openBox<Pomodoro>('POMODORO');

  AppDependencies.injectDependencies();

  runApp(const Listzilla());
}

class Listzilla extends StatefulWidget {
  const Listzilla({Key? key}) : super(key: key);

  @override
  _ListzillaState createState() => _ListzillaState();
}

class _ListzillaState extends State<Listzilla> {
  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
