import 'package:flutter/material.dart';

class SettingsAbout extends StatelessWidget {
  const SettingsAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme themeStyle = Theme.of(context).textTheme;
    return Column(
    mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Open Source app for task management\n",
          textAlign: TextAlign.center,
          style: themeStyle.bodyText2,
        ),
        Text(
          "Follow me on GitHub: /DJuan33\n",
          textAlign: TextAlign.center,
          style: themeStyle.bodyText2,
        ),
        Text(
          ":D",
          textAlign: TextAlign.center,
          style: themeStyle.bodyText2,
        ),
        TextButton(child: const Text("OK"),onPressed: () => Navigator.of(context).pop(),)
      ],
    );
  }
}
