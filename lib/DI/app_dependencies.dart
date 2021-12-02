import 'package:kiwi/kiwi.dart';
import 'package:listzilla/UI/routes.dart';
import 'package:listzilla/data/repositories/grouplist_repository_hive.dart';
import 'package:listzilla/data/repositories/pomodoro_repository_hive.dart';
import 'package:listzilla/data/repositories/tasklist_repository_hive.dart';
import 'package:listzilla/data/repositories/task_repository_hive.dart';
import 'package:listzilla/data/repositories/user_repository_hive.dart';
import 'package:listzilla/domain/controllers/app_theme/app_theme_controller.dart';
import 'package:listzilla/domain/controllers/calendar/calendar_screen_controller.dart';
import 'package:listzilla/domain/controllers/home/home_screen_controller.dart';
import 'package:listzilla/domain/controllers/pomodoro/pomodoro_screen_controller.dart';
import 'package:listzilla/domain/controllers/search/search_screen_controller.dart';
import 'package:listzilla/domain/controllers/sidebar/sidebar_screen_controller.dart';
import 'package:listzilla/domain/controllers/task_detail/taskdetail_screen_controller.dart';
import 'package:listzilla/domain/controllers/tasklist/tasklist_screen_controller.dart';
import 'package:listzilla/domain/repositories/grouplist_repository.dart';
import 'package:listzilla/domain/repositories/pomodoro_repository.dart';
import 'package:listzilla/domain/repositories/tasklist_repository.dart';
import 'package:listzilla/domain/repositories/task_repository.dart';
import 'package:listzilla/domain/repositories/user_repository.dart';

abstract class AppDependencies {
  /// The container for the dependency injection.
  static final KiwiContainer dependencyInjector = KiwiContainer();

  static void injectDependencies() {
    // Routes singleton
    dependencyInjector.registerSingleton<AppRouter>((c) => AppRouter());

    // Repositories factories
    dependencyInjector
        .registerFactory<UserRepositoryInterface>((c) => UserRepositoryHive());
    dependencyInjector
        .registerFactory<TaskRepositoryInterface>((c) => TaskRepositoryHive());
    dependencyInjector.registerFactory<TaskListRepositoryInterface>(
        (c) => TaskListRepositoryHive());
    dependencyInjector.registerFactory<GroupListRepositoryInterface>(
        (c) => GroupListRepositoryHive());
    dependencyInjector.registerFactory<PomodoroRepositoryInterface>(
        (c) => PomodoroRepositoryHive());

    // BLoCs
    dependencyInjector.registerSingleton((c) => AppThemeController());

    dependencyInjector.registerSingleton(
      (c) => HomeScreenController(
        userRepository: dependencyInjector.resolve(),
      ),
    );

    dependencyInjector.registerSingleton(
      (c) => SidebarScreenController(
        groupListDBConnection: dependencyInjector.resolve(),
        taskListDBConnection: dependencyInjector.resolve(),
        taskDBConnection: dependencyInjector.resolve(),
      ),
    );

    dependencyInjector.registerSingleton(
      (c) => TaskListScreenController(
        taskDBConnection: dependencyInjector.resolve(),
        taskListDBConnection: dependencyInjector.resolve(),
      ),
    );

    dependencyInjector.registerSingleton(
      (c) => TaskDetailScreenController(
        taskDBConnection: dependencyInjector.resolve(),
      ),
    );

    dependencyInjector.registerSingleton(
      (c) => SearchScreenController(
        taskDBConnection: dependencyInjector.resolve(),
        taskListDBConnection: dependencyInjector.resolve(),
      ),
    );

    dependencyInjector.registerSingleton(
      (c) => CalendarScreenController(
        taskDBConnection: dependencyInjector.resolve(),
      ),
    );

    dependencyInjector.registerSingleton(
      (c) => PomodoroScreenController(
        pomodoroDBConnection: dependencyInjector.resolve(),
        userDBConnection: dependencyInjector.resolve(),
      ),
    );
  }
}
