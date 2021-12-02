import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/domain/controllers/home/home_screen_controller.dart';
import 'package:listzilla/domain/controllers/home/home_screen_state.dart';

class HomeNavBar extends StatelessWidget {
  final HomeScreenController homeScreenController =
      AppDependencies.dependencyInjector.resolve();

  HomeNavBar({Key? key}) : super(key: key);

// TODO: Add indicators to the selected tab.
  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);

    return BlocBuilder<HomeScreenController, HomeScreenState>(
      bloc: homeScreenController,
      builder: (context, state) {
        return state.isLoading
            ? Container(
                height: 0,
              )
            : BottomAppBar(
                shape: const CircularNotchedRectangle(),
                elevation: 3,
                color: themeContext.brightness == Brightness.dark
                    ? null
                    : themeContext.colorScheme.primary,
                child: SizedBox(
                  height: 69,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 7,
                        child: BottomNavigationBar(
                          backgroundColor: Colors.transparent,
                          iconSize: 33,
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          elevation: 0,
                          onTap: (value) => {
                            homeScreenController.setTabIndex(value),
                          },
                          currentIndex: state.tabIndex,
                          items: [
                            // TODO: Add this to a builder.
                            _bottomNavBarItem(
                              Icons.task_outlined,
                              themeContext,
                              "Task List",
                              state.tabIndex == 0 ? true : false,
                            ),
                            _bottomNavBarItem(
                              Icons.search,
                              themeContext,
                              "Search Task",
                              state.tabIndex == 1 ? true : false,
                            ),
                            _bottomNavBarItem(
                              Icons.calendar_today_outlined,
                              themeContext,
                              "Calendar",
                              state.tabIndex == 2 ? true : false,
                            ),
                            _bottomNavBarItem(
                              Icons.timer_outlined,
                              themeContext,
                              "Pomodoro",
                              state.tabIndex == 3 ? true : false,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(),
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }

  BottomNavigationBarItem _bottomNavBarItem(
      IconData icon, ThemeData themeContext, String tooltip, bool isSelected) {
    Icon itemIcon = Icon(
      icon,
      size: 24,
      color: !isSelected
          ?  themeContext.brightness == Brightness.dark ? Colors.grey : Colors.grey.shade300
          : themeContext.brightness == Brightness.dark
              ? themeContext.colorScheme.primary
              : Colors.white,
    );

    return BottomNavigationBarItem(
        tooltip: tooltip,
        label: tooltip,
        backgroundColor: Colors.transparent,
        icon: itemIcon);
  }
}
