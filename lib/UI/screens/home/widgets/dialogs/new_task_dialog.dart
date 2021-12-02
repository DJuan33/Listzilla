import 'package:flutter/material.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/domain/controllers/tasklist/tasklist_screen_controller.dart';

class NewTaskDialog extends StatefulWidget {
  final DateTime noTime = DateTime.fromMillisecondsSinceEpoch(0);
  final bool isPriority;
  final bool isMyDay;

  NewTaskDialog({Key? key,required this.isPriority, this.isMyDay = false}) : super(key: key);
  @override
  _NewTaskDialogState createState() => _NewTaskDialogState();
}

class _NewTaskDialogState extends State<NewTaskDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<String> taskData = ["", "", "", "", ""];
  bool _buttonEnabled = false;
  bool _isPriority = false;
  DateTime _expirationDate = DateTime.fromMillisecondsSinceEpoch(0);

  final TaskListScreenController _taskListScreenController =
      AppDependencies.dependencyInjector.resolve();

  void _setButtonState() {
    if (nameController.text.isNotEmpty) {
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
    final ThemeData themeContext = Theme.of(context);
    final Color primaryColor = themeContext.colorScheme.primary;

    final Icon priorityIcon = Icon(
      Icons.star,
      color: primaryColor,
      size: 33,
    );

    final Icon noPriorityIcon = Icon(
      Icons.star_border,
      color: primaryColor,
      size: 33,
    );

    final Icon dateIcon = Icon(
      Icons.query_builder,
      color: primaryColor,
      size: 27,
    );

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width > 1500) ? 300 : 90),
      child: Padding(
        padding: const EdgeInsets.all(33.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "New Task",
                  textAlign: TextAlign.left,
                  style: themeContext.textTheme.subtitle1,
                ),
                IconButton(
                    icon: _isPriority ? priorityIcon : noPriorityIcon,
                    onPressed: () {
                      setState(() {
                        _isPriority = !_isPriority;
                      });
                    }),
              ],
            ),
            // TODO: This text field as a global widget.
            TextField(
              style: themeContext.textTheme.bodyText2,
              controller: nameController,
              decoration: InputDecoration(
                hintStyle: themeContext.textTheme.bodyText2!
                    .copyWith(color: Colors.grey),
                counterStyle: themeContext.textTheme.bodyText2!
                    .copyWith(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.0, color: themeContext.colorScheme.primary),
                ),
                hintText: 'Task name',
                border: const UnderlineInputBorder(),
              ),
            ),
            Flexible(
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 0),
                title: Text(
                  "Advanced options".toUpperCase(),
                  style: themeContext.textTheme.button,
                ),
                collapsedTextColor: themeContext.hintColor,
                collapsedIconColor: themeContext.hintColor,
                children: [
                  Column(
                    children: [
                      Card(
                        margin: const EdgeInsets.only(top: 18, bottom: 9),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 21),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 9),
                                child: Text(
                                  "Date options:",
                                  textAlign: TextAlign.start,
                                  style: themeContext.textTheme.bodyText1,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(right: 24),
                                      child: dateIcon),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => _pickDate(context),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Theme.of(context)
                                                      .hintColor)),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          child: Text(
                                            _expirationDate.compareTo(
                                                        widget.noTime) ==
                                                    0
                                                ? "Set expiration Date"
                                                : getExpirationDate(),
                                            style: themeContext
                                                .textTheme.bodyText2!
                                                .copyWith(
                                                    color: _expirationDate
                                                                .compareTo(widget
                                                                    .noTime) ==
                                                            0
                                                        ? Theme.of(context)
                                                            .hintColor
                                                        : null),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        /* padding: EdgeInsets.symmetric(horizontal: 12), */
                        child: Card(
                          margin: const EdgeInsets.only(top: 18, bottom: 9),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 21),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 9),
                                  child: Text(
                                    "Note:",
                                    textAlign: TextAlign.start,
                                    style: themeContext.textTheme.bodyText1,
                                  ),
                                ),
                                SizedBox(
                                  height: 300,
                                  child: TextField(
                                    maxLines: null,
                                    style: themeContext.textTheme.bodyText2,
                                    controller: descriptionController,
                                    decoration: InputDecoration(
                                      hintStyle: themeContext
                                          .textTheme.bodyText2!
                                          .copyWith(color: Colors.grey),
                                      counterStyle: themeContext
                                          .textTheme.bodyText2!
                                          .copyWith(color: Colors.grey),
                                      focusedBorder: InputBorder.none,
                                      hintText: 'Add a description',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
                    child: TextButton(
                      child: const Text("Create"),
                      onPressed: _buttonEnabled ? () => sendData() : null,
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

  String getExpirationDate() {
    return "${_expirationDate.day}/${_expirationDate.month}/${_expirationDate.year}";
  }

  void sendData() {
    if (_buttonEnabled) {
      _taskListScreenController.newTask(
        taskName: nameController.text,
        taskDescription: descriptionController.text,
        taskPriority: _isPriority,
        taskExpirationDate: _expirationDate,
        taskMyDay: widget.isMyDay,
      );
      Navigator.pop(context);
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2033));

    if (picked != null) {
      setState(() {
        _expirationDate = picked;
      });
    }
  }

  @override
  void initState() {
    nameController.addListener(_setButtonState);
    _isPriority = widget.isPriority;
    _expirationDate = widget.isMyDay
        ? DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            23,
            59,
          )
        : _expirationDate;
    super.initState();
  }
}
