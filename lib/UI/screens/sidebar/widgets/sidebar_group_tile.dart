import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/sidebar_list_tile.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/sidebar_tile_trailing.dart';
import 'package:listzilla/domain/controllers/app_theme/app_theme_controller.dart';
import 'package:listzilla/domain/controllers/sidebar/sidebar_screen_controller.dart';
import 'package:listzilla/domain/controllers/sidebar/sidebar_screen_state.dart';
import 'package:listzilla/domain/models/task_list_model.dart';

class SidebarGroupTiles extends StatefulWidget {
  final String groupName;
  final int groupIndex;
  final int groupColorCode;
  final String groupID;

  const SidebarGroupTiles({Key? key, 
    required this.groupName,
    required this.groupIndex,
    required this.groupColorCode,
    required this.groupID,
  }) : super(key: key);

  @override
  _SidebarGroupTilesState createState() => _SidebarGroupTilesState();
}

class _SidebarGroupTilesState extends State<SidebarGroupTiles> {
  final SidebarScreenController sidebarScreenController =
      AppDependencies.dependencyInjector.resolve();

  final AppThemeController themeController =
      AppDependencies.dependencyInjector.resolve();

  IconData trailingIcon = Icons.expand_more;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);
    int themeMode = themeContext.brightness == Brightness.light ? 0 : 1;
    Color colorTag =
        themeController.getColorFromCode(widget.groupColorCode, themeMode);

    return BlocBuilder<SidebarScreenController, SidebarScreenState>(
      bloc: sidebarScreenController,
      builder: (context, state) {
        // TODO: Change tasklist List to a Map.
        final List<TaskList?>? taskLists = state.taskLists[widget.groupID];

        return taskLists != null
            ? Theme(
                data: themeContext.copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  trailing: SidebarTileTrailing(
                    colorTag: colorTag,
                    trailingIcon: trailingIcon,
                    groupID: widget.groupID,
                  ),
                  leading: Icon(
                    Icons.add_box,
                    color: colorTag,
                  ),
                  title: Text(
                    widget.groupName.toUpperCase(),
                    style: themeContext.textTheme.bodyText1!
                        .copyWith(color: colorTag),
                    textAlign: TextAlign.center,
                  ),
                  onExpansionChanged: (bool expanded) {
                    if (expanded) {
                      setState(() {
                        trailingIcon = Icons.expand_less;
                      });
                    } else {
                      setState(() {
                        trailingIcon = Icons.expand_more;
                      });
                    }
                  },
                  children: [
                    taskLists.isNotEmpty
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
                                    listColorCode: widget.groupColorCode,
                                    listID: taskList.id);
                              } else {
                                return const Text("a");
                              }
                            },
                          )
                        : Container(
                            margin: const EdgeInsets.only(top: 6, bottom: 6),
                            child: DottedBorder(
                              color: Colors.grey,
                              radius: const Radius.circular(100),
                              strokeWidth: 1,
                              dashPattern: const [3, 2],
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 21),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(right: 12.0),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "Empty group\nTry to add some lists",
                                      style: themeContext.textTheme.bodyText2!
                                          .copyWith(
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              )
            : Container();
      },
    );
  }
}
