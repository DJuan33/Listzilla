import 'package:flutter/material.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/dialogs/new_list_modal.dart';
import 'package:listzilla/domain/controllers/sidebar/sidebar_screen_controller.dart';
import 'package:listzilla/domain/controllers/tasklist/tasklist_screen_controller.dart';

import 'dialogs/new_list_dialog.dart';

/// Trailing part of the [SidebarGroupTiles] head bar.
class SidebarTileTrailing extends StatelessWidget {
  /// Sidebar Controller
  final SidebarScreenController _sidebarScreenController =
      AppDependencies.dependencyInjector.resolve();

  final TaskListScreenController _taskListScreenController =
      AppDependencies.dependencyInjector.resolve();

  /// The more/less icon.
  final IconData trailingIcon;

  /// The color tag of the group.
  final Color colorTag;

  /// Group id for adding data.
  final String groupID;

  SidebarTileTrailing(
      {Key? key,
      required this.colorTag,
      required this.trailingIcon,
      required this.groupID})
      : super(key: key);

  /// Returns a bool that indicate if the app is running in a mobile screen size.
  bool isMobileScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width <= 1200;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // The button for triggering the group list actions.
        PopupMenuButton(
          onSelected: (value) => {
            if (value == GroupListOptions.add)
              {
                isMobileScreenSize(context)
                    ? showModalBottomSheet(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
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
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: NewTaskListModal(groupListID: groupID),
                          );
                        },
                      )
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NewTaskListDialog(groupListID: groupID);
                        }),
              }
            else
              {
                deleteGroup(),
              }
          },
          itemBuilder: (context) => <PopupMenuEntry<GroupListOptions>>[
            PopupMenuItem<GroupListOptions>(
              value: GroupListOptions.add,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      Icons.add,
                      color: colorTag,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Add Task List",
                      textAlign: TextAlign.center,
                      style: themeContext.textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<GroupListOptions>(
              value: GroupListOptions.delete,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      Icons.delete_outline,
                      color: colorTag,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Delete Group",
                      textAlign: TextAlign.center,
                      style: themeContext.textTheme.bodyText2,
                    ),
                  )
                ],
              ),
            ),
          ],
          icon: Icon(
            Icons.more_vert,
            color: colorTag,
          ),
          padding: const EdgeInsets.all(0),
        ),

        // The expansion indicator icon.
        Icon(
          trailingIcon,
          color: colorTag,
        )
      ],
    );
  }

  //TODO: Add functionality.
  void deleteGroup() {
    _sidebarScreenController.deleteGroup(groupID);
    _taskListScreenController.refresh();
  }
}

enum GroupListOptions { add, delete }
