import 'package:flutter/material.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/dialogs/new_grouplist_dialog.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/dialogs/new_grouplist_modal.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/dialogs/new_list_dialog.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/dialogs/new_list_modal.dart';

class SidebarNewItems extends StatelessWidget {
  const SidebarNewItems({Key? key}) : super(key: key);

  /// Returns a bool that indicate if the app is running in a mobile screen size.
  bool isMobileScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width <= 1200;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeContext = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              // TODO: Extract modal widget and create an only class for this.
              child: newItem(
                "New List",
                const Icon(Icons.add, size: 21),
                // TODO: Extract bottomsheet and alert dialog themes.
                () {
                  return isMobileScreenSize(context)
                      ? showModalBottomSheet(
                          backgroundColor: themeContext.scaffoldBackgroundColor,
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
                                child: const NewTaskListModal(
                                    groupListID: "333-333-333"));
                          })
                      : showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const NewTaskListDialog(
                                groupListID: "333-333-333");
                          });
                },
                context,
              ),
            ),
            Expanded(
              child: newItem(
                "New Group",
                const Icon(Icons.queue, size: 21),
                () {
                  return isMobileScreenSize(context)
                      ? showModalBottomSheet(
                          backgroundColor: themeContext.scaffoldBackgroundColor,
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
                                child: const NewGroupListModal());
                          },
                        )
                      : showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const NewGroupListDialog();
                          });
                },
                context,
              ),
            ),
          ],
        ),
      ],
    );
  }

  ListTile newItem(
      String title, Icon icon, Function function, BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 3),
      leading: TextButton.icon(
        icon: icon,
        label: Text(
          title,
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: () => function(),
      ),
    );
  }
}
