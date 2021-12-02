import 'package:flutter/material.dart';
import 'package:listzilla/UI/screens/settings/widgets/dialogs/about_dialog.dart';
import 'package:listzilla/UI/screens/settings/widgets/settings_theme_switcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              "Settings",
              style: themeContext.textTheme.subtitle1,
            ),
            elevation: 0),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 6),
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: ListTile(
                  dense: true,
                  leading: const Text("Version"),
                  trailing: Text(
                    "0.6",
                    style: themeContext.textTheme.bodyText2!
                        .copyWith(color: themeContext.disabledColor),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: const ListTile(
                  dense: true,
                  leading: Text("Choose Theme"),
                  trailing: SettingsThemeSwitch(),
                ),
              ),
              InkWell(
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        title: Text(
                          "About Listzilla",
                          style: themeContext.textTheme.subtitle1,
                          textAlign: TextAlign.center,
                        ),
                        content: const SettingsAbout());
                  },
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 9),
                  child: ListTile(
                    dense: true,
                    leading: Text(
                      "About Listzilla",
                      style: themeContext.textTheme.bodyText2,
                    ),
                  ),
                ),
              ),
            ],
          ).toList(),
        ),
      ),
    );
  }
}
