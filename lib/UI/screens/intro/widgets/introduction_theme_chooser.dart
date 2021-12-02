import 'package:flutter/material.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/domain/controllers/app_theme/app_theme_controller.dart';

class IntroThemeChooser extends StatefulWidget {
  const IntroThemeChooser({Key? key}) : super(key: key);

  @override
  _IntroThemeChooserState createState() => _IntroThemeChooserState();
}

class _IntroThemeChooserState extends State<IntroThemeChooser> {
  int _value = 0;

  final AppThemeController themeController =
      AppDependencies.dependencyInjector.resolve();

  void toggleThemeMode(int value) {
    themeController.setThemeMode(value);
  }

  void changeTheme(int? value) {
    if (value != null) {
      setState(() {
        _value = value;
      });
      toggleThemeMode(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 900),
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RadioListTile(
              title: Text(
                "☀️   Light",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 27,
                    ),
              ),
              value: 0,
              groupValue: _value,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (int? value) => changeTheme(value)),
          const SizedBox(height: 30),
          RadioListTile(
              title: Text(
                "🌙  Dark",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 27,
                    ),
              ),
              value: 1,
              groupValue: _value,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (int? value) => changeTheme(value)),
        ],
      ),
    );
  }
}
