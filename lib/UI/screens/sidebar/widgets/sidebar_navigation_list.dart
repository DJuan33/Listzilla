import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/sidebar_group_tile.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/sidebar_navigation/sidebar_navigation_tile.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/sidebar_smartlists_tiles.dart';
import 'package:listzilla/domain/controllers/sidebar/sidebar_screen_controller.dart';
import 'package:listzilla/domain/controllers/sidebar/sidebar_screen_state.dart';
import 'package:listzilla/domain/models/group_list_model.dart';

class SidebarNavigationList extends StatefulWidget {
  const SidebarNavigationList({Key? key}) : super(key: key);

  @override
  State<SidebarNavigationList> createState() => _SidebarNavigationListState();
}

class _SidebarNavigationListState extends State<SidebarNavigationList> with AutomaticKeepAliveClientMixin {
  final SidebarScreenController _sidebarScreenController =
      AppDependencies.dependencyInjector.resolve();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
          SidebarNavigationTile(listName: "Task list", listIcon: const Icon(Icons.task_outlined), tabIndex: 0),
          SidebarNavigationTile(listName: "Search", listIcon: const Icon(Icons.search), tabIndex: 1),
          SidebarNavigationTile(listName: "Calendar", listIcon: const Icon(Icons.calendar_today_outlined), tabIndex: 2),
          SidebarNavigationTile(listName: "Pomodoro", listIcon: const Icon(Icons.timer_outlined), tabIndex: 3),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

