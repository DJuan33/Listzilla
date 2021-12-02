import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/domain/controllers/sidebar/sidebar_screen_controller.dart';

class NewTaskListModal extends StatefulWidget {
  final String groupListID;

  const NewTaskListModal({Key? key, required this.groupListID})
      : super(key: key);

  @override
  _NewTaskListModalState createState() => _NewTaskListModalState();
}

class _NewTaskListModalState extends State<NewTaskListModal> {
  final TextEditingController newListNameController = TextEditingController();
  final SidebarScreenController _sidebarScreenController =
      AppDependencies.dependencyInjector.resolve();

  bool _buttonEnabled = false;
  bool _showEmojiPicker = false;
  String emoji = "";

  void _setButtonState() {
    if (newListNameController.text.isNotEmpty) {
      setState(() {
        _buttonEnabled = true;
      });
    } else {
      setState(() {
        _buttonEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);
    final Color primaryColor = themeContext.colorScheme.primary;
    final Color scaffoldColor = themeContext.scaffoldBackgroundColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Create Task List",
            textAlign: TextAlign.left,
            style: themeContext.textTheme.subtitle1,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: TextField(
              style: themeContext.textTheme.bodyText2,
              controller: newListNameController,
              decoration: InputDecoration(
                hintStyle: themeContext.textTheme.bodyText2!
                    .copyWith(color: Colors.grey),
                counterStyle: themeContext.textTheme.bodyText2!
                    .copyWith(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.0, color: themeContext.colorScheme.primary),
                ),
                hintText: 'List name',
                border: const UnderlineInputBorder(),
              ),
            ),
          ),
          if (defaultTargetPlatform == TargetPlatform.android)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Choose a emoji (optional):",
                  style: themeContext.textTheme.bodyText1,
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      _showEmojiPicker = true;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 18),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(
                          width: 1,
                          color: primaryColor,
                        )),
                    height: 45,
                    width: 45,
                    child: Center(
                      child: emoji == ""
                          ? Icon(Icons.insert_emoticon, color: primaryColor)
                          : Text(
                              emoji,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          Container(
              padding: const EdgeInsets.fromLTRB(9, 18, 9, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      child: const Text("Cancel"),
                      onPressed: () => Navigator.of(context).pop()),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: ElevatedButton(
                      child: const Text("Create"),
                      onPressed: !_buttonEnabled ? null : () => _sendData(),
                    ),
                  ),
                ],
              )),
          (_showEmojiPicker
              ? SizedBox(
                  height: 300,
                  child: showEmojiPicker(scaffoldColor, primaryColor))
              : Container()),
        ],
      ),
    );
  }

  void _sendData() {
    if (_buttonEnabled) {
      _sidebarScreenController.newTaskList(
          widget.groupListID, newListNameController.text, emoji);
      Navigator.of(context).pop();
    }
  }

  Widget showEmojiPicker(Color backgroundColor, Color primaryColor) {
    // TODO: Set emojis initial tab to faces, not to recently.
    return EmojiPicker(
      config: Config(
        bgColor: backgroundColor,
        columns: 6,
        iconColorSelected: primaryColor,
        indicatorColor: primaryColor,
      ),
      onEmojiSelected: (emoji, category) {
        setState(() {
          this.emoji = category.emoji;
          _showEmojiPicker = false;
        });
      },
    );
  }

  @override
  void initState() {
    newListNameController.addListener(_setButtonState);
    super.initState();
  }
}
