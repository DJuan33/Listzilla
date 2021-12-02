import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/UI/global_widgets/loading_container.dart';
import 'package:listzilla/UI/routes.dart';
import 'package:listzilla/UI/routes_names.dart';
import 'package:listzilla/UI/screens/calendar/calendar_screen.dart';
import 'package:listzilla/UI/screens/home/widgets/dialogs/new_task_dialog.dart';
import 'package:listzilla/UI/screens/home/widgets/dialogs/new_task_modal.dart';
import 'package:listzilla/UI/screens/home/widgets/home_navbar.dart';
import 'package:listzilla/UI/screens/pomodoro/pomodoro_screen.dart';
import 'package:listzilla/UI/screens/search/search_screen.dart';
import 'package:listzilla/UI/screens/sidebar/sidebar_drawer.dart';
import 'package:listzilla/UI/screens/sidebar/sidebar_screen.dart';
import 'package:listzilla/UI/screens/task_detail/taskdetail_screen.dart';
import 'package:listzilla/UI/screens/task_list/tasklist_screen.dart';
import 'package:listzilla/domain/controllers/app_theme/app_theme_controller.dart';
import 'package:listzilla/domain/controllers/app_theme/app_theme_state.dart';
import 'package:listzilla/domain/controllers/home/home_screen_controller.dart';
import 'package:listzilla/domain/controllers/home/home_screen_state.dart';
import 'package:listzilla/domain/controllers/search/search_screen_controller.dart';
import 'package:listzilla/domain/controllers/sidebar/sidebar_screen_controller.dart';
import 'package:listzilla/domain/controllers/tasklist/tasklist_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AppRouter _router = AppDependencies.dependencyInjector.resolve();
  final HomeScreenController _homeScreenController =
      AppDependencies.dependencyInjector.resolve();
  final AppThemeController _themeController =
      AppDependencies.dependencyInjector.resolve();
  final SidebarScreenController _sidebarScreenController =
      AppDependencies.dependencyInjector.resolve();
  final TaskListScreenController _taskListScreenController =
      AppDependencies.dependencyInjector.resolve();
  final SearchScreenController _searchScreenController =
      AppDependencies.dependencyInjector.resolve();

  bool introPushed = false;

  /// List of the screens active on the [TabBarView].
  final List<Widget> tabScreens = [
    TaskListScreen(),
    SearchScreen(),
    const CalendarScreen(),
    const PomodoroScreen(),
  ];

  /// Returns a bool that indicate if the app is running in a mobile screen size.
  bool isMobileScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width <= 1200;
  }

 /// Returns a bool that indicate if the app is running in a large screen size.
  bool isLargeScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width <= 1800;
  }

  @override
  void initState() {
    super.initState();

    /// When the widgets builted, orders to the controller to fetch the data.
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        if (!_homeScreenController.checkUserExists()) {
          await _homeScreenController.createNewUser();
          _homeScreenController.addData();
        } else {
          _homeScreenController.setLoadingFalse();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    

    return BlocBuilder<AppThemeController, AppThemeState>(
      bloc: _themeController,
      builder: (context, themeState) {
        return MaterialApp(
          theme: _themeController.getTheme(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: _router.generateRoute,
          home: Builder(
            builder: (context) {
              ThemeData themeContext = Theme.of(context);
              return SafeArea(
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  drawer: const SidebarDrawer(),
                  floatingActionButton: FloatingActionButton(
                      onPressed: () async {
                        isMobileScreenSize(context)
                            ? showModalBottomSheet(
                                    backgroundColor:
                                        themeContext.scaffoldBackgroundColor,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(33),
                                      ),
                                    ),
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return SingleChildScrollView(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: NewTaskModal(
                                            priority: _taskListScreenController
                                                .actualListIsPriority(),
                                            isMyDay: _taskListScreenController.actualListIsMyDay(),
                                          ));
                                    })
                                .then(
                                    (_) => _homeScreenController.setTabIndex(0))
                            : showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return NewTaskDialog(
                                        isPriority: _taskListScreenController
                                            .actualListIsPriority(),
                                            isMyDay: _taskListScreenController.actualListIsMyDay(),
                                      );
                                    })
                                .then((_) =>
                                    _homeScreenController.setTabIndex(0));
                      },
                      child: Icon(Icons.add_task_outlined,
                          color: Theme.of(context).colorScheme.background)),
                  floatingActionButtonLocation: isMobileScreenSize(context)
                      ? FloatingActionButtonLocation.endDocked
                      : FloatingActionButtonLocation.endFloat,
                  body: BlocConsumer<HomeScreenController, HomeScreenState>(
                    listener: (context, homeState) async {
                      if (!homeState.dataAdded) {
                        await Navigator.pushNamed(context, RouteNames.intro);
                      }
                      if (homeState.isLoading) {
                        _homeScreenController.setLoadingFalse();
                      }
                      if (!homeState.controllersLoaded) {
                        _sidebarScreenController.onInit();
                        _taskListScreenController.onInit();
                        _searchScreenController.onInit();
                        _homeScreenController.setControllersLoadedTrue();
                      }
                    },
                    bloc: _homeScreenController,
                    builder: (context, state) {
                      return state.isLoading
                          ? const ListzillaLoading()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                isMobileScreenSize(context)
                                    ? const SizedBox()
                                    : Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 300),
                                        child: const SidebarScreen(),
                                      ),
                                Flexible(
                                  flex: isLargeScreenSize(context)
                                      ? 4
                                      : 4,
                                  child: IndexedStack(
                                    index: state.tabIndex,
                                    children: tabScreens,
                                  ),
                                ),
                                state.showTaskDetail
                                    ? Container(
                                        child: isMobileScreenSize(context)
                                            ? const SizedBox()
                                            : Flexible(
                                                flex: isLargeScreenSize(context)
                                                    ? 2
                                                    : 3,
                                                child: TaskDetailScreen()),
                                      )
                                    : const SizedBox(),
                              ],
                            );
                    },
                  ),
                  bottomNavigationBar:
                      isMobileScreenSize(context) ? HomeNavBar() : null,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
