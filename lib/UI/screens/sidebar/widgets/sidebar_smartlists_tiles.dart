import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/sidebar_list_tile.dart';
import 'package:listzilla/domain/controllers/sidebar/sidebar_screen_controller.dart';
import 'package:listzilla/domain/controllers/sidebar/sidebar_screen_state.dart';
import 'package:listzilla/domain/models/task_list_model.dart';

class SidebarSmartLists extends StatefulWidget {
  const SidebarSmartLists({Key? key}) : super(key: key);

  @override
  _SidebarSmartListsState createState() => _SidebarSmartListsState();
}

class _SidebarSmartListsState extends State<SidebarSmartLists> {
  final SidebarScreenController sidebarScreenController =
      AppDependencies.dependencyInjector.resolve();

  IconData trailingIcon = Icons.expand_more;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SidebarScreenController, SidebarScreenState>(
      bloc: sidebarScreenController,
      builder: (context, state) {
        final List<TaskList?>? taskLists = state.taskLists["333-333-333"];

        return taskLists != null
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: taskLists.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  TaskList? taskList = taskLists[index];
                  if (taskList != null) {
                    return SidebarListTile(
                      listEmoji: taskList.emoji,
                      listName: taskList.name,
                      listColorCode: 0,
                      listID: taskList.id,
                    );
                  } else {
                    return const Text("a");
                  }
                },
              )
            : Container();
      },
    );
  }
}

enum GroupListOptions { add, delete }
