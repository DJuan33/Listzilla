import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';

class PomodoroLengthDialog extends StatefulWidget {
  const PomodoroLengthDialog({Key? key,required this.dialogTitle}) : super(key: key);
  final String dialogTitle;

  @override
  _PomodoroLengthDialogState createState() => _PomodoroLengthDialogState();
}

class _PomodoroLengthDialogState extends State<PomodoroLengthDialog> {
  Duration _duration = const Duration(hours: 0, minutes: 0);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        widget.dialogTitle,
        style: Theme.of(context).textTheme.subtitle1,
        textAlign: TextAlign.center,
      ),
      content: DurationPicker(
        duration: _duration,
        onChange: (val) {
          setState(() => _duration = val);
        },
        snapToMins: 5.0,
      ),
      actions: [
        TextButton(
          // TODO: Add the -1 to app constants.
          onPressed: () => Navigator.pop(context, -1),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _duration.inMinutes),
          child: const Text("OK"),
        )
      ],
    );
  }
}
