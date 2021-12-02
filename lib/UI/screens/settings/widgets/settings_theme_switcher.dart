import 'package:flutter/material.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/domain/controllers/app_theme/app_theme_controller.dart';

class SettingsThemeSwitch extends StatefulWidget {
  const SettingsThemeSwitch({Key? key}) : super(key: key);


  @override
  _SettingsThemeSwitchState createState() =>
      _SettingsThemeSwitchState();
}

class _SettingsThemeSwitchState extends State<SettingsThemeSwitch> {

  final AppThemeController _themeController =
      AppDependencies.dependencyInjector.resolve();

  void setTheme(bool value) {
    if (value) {
      _themeController.setThemeMode(1);
    } else {
      _themeController.setThemeMode(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);
    bool themeMode = Theme.of(context).brightness == Brightness.dark ? true : false;
    return Switch(
    activeColor: themeContext.colorScheme.primary,
    activeTrackColor: themeContext.colorScheme.primary,
      value: themeMode,
      onChanged: (value) => setTheme(value),
    );
  }
}
