import 'package:flutter/material.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/domain/controllers/app_theme/app_theme_controller.dart';
import 'package:listzilla/domain/controllers/home/home_screen_controller.dart';
import 'package:listzilla/domain/controllers/tasklist/tasklist_screen_controller.dart';

class SidebarListTile extends StatelessWidget {
  final int listColorCode;
  final String listEmoji;
  final String listName;
  final String listID;

  final AppThemeController _themeController =
      AppDependencies.dependencyInjector.resolve();

  final TaskListScreenController _taskListScreenController =
      AppDependencies.dependencyInjector.resolve();
  
  final HomeScreenController _homeScreenController = AppDependencies.dependencyInjector.resolve();

  SidebarListTile({
    Key? key,
    required this.listName,
    required this.listEmoji,
    required this.listColorCode,
    required this.listID,
  }) : super(key: key);

  Icon _getIcon(int themeMode) {
    Icon regularListIcon = Icon(
      Icons.list_outlined,
      color: _themeController.getColorFromCode(listColorCode, themeMode),
    );
    Icon priorityListIcon = Icon(
      Icons.star,
      color: _themeController.getColorFromCode(listColorCode, themeMode),
    );
    Icon myDayListIcon = Icon(
      Icons.flare_outlined,
      color: _themeController.getColorFromCode(listColorCode, themeMode),
    );
    switch (listID) {
      case "Priority":
        return priorityListIcon;
      case "My day":
        return myDayListIcon;
      default:
        return regularListIcon;
    }
  }

  /// If the list is a smart list, returns true;
  bool checkSmartList() {
    switch (listID) {
      case "Priority":
        return true;
      case "My day":
        return true;
      default:
        return false;
    }
  }

  /// Returns a bool that indicate if the app is running in a mobile screen size.
  bool isMobileScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width <= 1200;
  }

  @override
  Widget build(BuildContext context) {
    int themeMode = Theme.of(context).brightness == Brightness.light ? 0 : 1;

    return Card(
      margin: const EdgeInsets.all(0),
      color: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              _themeController.setPrimaryColor(listColorCode);
              _taskListScreenController.setTaskListID(listID);
              _taskListScreenController.setListUnDeleteable(!checkSmartList());
              _homeScreenController.setTabIndex(0);
              if (isMobileScreenSize(context)) {
                Navigator.pop(context);
              }
            },
            child: ListTile(
              dense: true,
              leading: listEmoji != ""
                  ? Text(
                      listEmoji,
                      textAlign: TextAlign.center,
                    )
                  : _getIcon(themeMode),
              title: Text(
                listName,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
