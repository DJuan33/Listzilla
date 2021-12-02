import 'package:flutter/material.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/domain/controllers/app_theme/app_theme_controller.dart';
import 'package:listzilla/domain/controllers/home/home_screen_controller.dart';
import 'package:listzilla/domain/controllers/tasklist/tasklist_screen_controller.dart';

class SidebarNavigationTile extends StatelessWidget {
  final Icon listIcon;
  final String listName;
  final int tabIndex;

  final HomeScreenController _homeScreenController = AppDependencies.dependencyInjector.resolve();

  SidebarNavigationTile({
    Key? key,
    required this.listName,
    required this.listIcon,
    required this.tabIndex,
  }) : super(key: key);


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
              _homeScreenController.setTabIndex(tabIndex);
            },
            child: ListTile(
              dense: true,
              leading: listIcon,
              trailing: const Icon(Icons.arrow_forward),
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

