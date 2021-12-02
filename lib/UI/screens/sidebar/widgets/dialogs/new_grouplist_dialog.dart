import 'package:flutter/material.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/domain/controllers/app_theme/app_theme_controller.dart';
import 'package:listzilla/domain/controllers/sidebar/sidebar_screen_controller.dart';

class NewGroupListDialog extends StatefulWidget {
  const NewGroupListDialog({Key? key}) : super(key: key);

  @override
  _NewGroupListDialogState createState() => _NewGroupListDialogState();
}

class _NewGroupListDialogState extends State<NewGroupListDialog> {
  final TextEditingController newGroupNameController = TextEditingController();
  final AppThemeController _themeController =
      AppDependencies.dependencyInjector.resolve();
  final SidebarScreenController _sidebarScreenController =
      AppDependencies.dependencyInjector.resolve();
  bool _buttonEnabled = false;
  int activeChip = 0;

  final List<Color> colorTags = [];

  void _setButtonState() {
    if (newGroupNameController.text.isNotEmpty) {
      setState(() {
        _buttonEnabled = true;
      });
    } else {
      setState(() {
        _buttonEnabled = false;
      });
    }
  }

  _setChipActive(int chipNumber) {
    setState(() {
      activeChip = chipNumber;
    });
  }

  Widget buildColorOptions(int chipValue, Color chipColor, bool chipActive) =>
      Container(
        padding: const EdgeInsets.only(left: 9, right: 9),
        child: RawMaterialButton(
          elevation: 0,
          onPressed: () {
            _setChipActive(chipValue);
          },
          fillColor: chipColor,
          shape: const CircleBorder(),
          child: Icon(
            Icons.circle,
            color: chipActive ? Colors.white : chipColor,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width > 1500) ? 465 : 145),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TODO: Set input decoration theme.
            Text(
              "Create Group List",
              textAlign: TextAlign.left,
              style: themeContext.textTheme.subtitle1,
            ),
            Container(
            margin:const EdgeInsets.symmetric(vertical:15),
              child: TextField(
                style: themeContext.textTheme.bodyText2,
                controller: newGroupNameController,
                decoration: InputDecoration(
                  hintStyle: themeContext.textTheme.bodyText2!
                      .copyWith(color: Colors.grey),
                  counterStyle: themeContext.textTheme.bodyText2!
                      .copyWith(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.0, color: themeContext.colorScheme.primary),
                  ),
                  hintText: 'Group name',
                  border: const UnderlineInputBorder(),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: 66,
                child: Container(
                  margin: const EdgeInsets.only(top: 15,bottom:6),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: colorTags.length,
                    itemBuilder: (BuildContext context, int index) =>
                        index == activeChip
                            ? buildColorOptions(index, colorTags[index], true)
                            : buildColorOptions(index, colorTags[index], false),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(9, 18, 9, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      child: const Text("Cancel"),
                      onPressed: () => Navigator.pop(context)),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    // TODO: Set TextButton theme and ElevatedButton theme styles.
                    child: ElevatedButton(
                      child: const Text("Create"),
                      onPressed: !_buttonEnabled ? null : () => _sendData(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendData() {
    if (_buttonEnabled) {
      // TODO: Send data here
      _sidebarScreenController.newGroupList(
          groupName: newGroupNameController.text, groupColor: activeChip);
      Navigator.pop(context);
    }
  }

  void _fillColors() {
    for (int x = 0; x < 9; x++) {
      colorTags.add(_themeController.getColorFromCode(
          x, _themeController.state.themeMode));
    }
  }

  @override
  void initState() {
    newGroupNameController.addListener(_setButtonState);
    _fillColors();
    super.initState();
  }
}

