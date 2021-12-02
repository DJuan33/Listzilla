import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/domain/controllers/app_theme/app_theme_controller.dart';

class TestScreen extends StatefulWidget {
  final String testText;
  const TestScreen({Key? key,required this.testText}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  final AppThemeController themeController =
      AppDependencies.dependencyInjector.resolve();
  int value = 0;

  void toggleThemeMode(int value) {
    setState(() {
            value = value;
                });
    themeController.setThemeMode(value);
  }

  void setPrimaryColor(AppThemeController themeController, int colorCode) {
    themeController.setPrimaryColor(colorCode);
  }

  List<TextButton> colorButtons(AppThemeController themeController) {
    List<TextButton> buttons = [];

    for (var x = 0; x < 9; x++) {
      buttons.add(TextButton(
        child: Text(
          "Color $x".toUpperCase(),
        ),
        onPressed: () => setPrimaryColor(themeController, x),
      ));
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: themeController,
      builder: (context, state) {
        return ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Title Text",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  TextButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                    child: Text(
                      "Regular Text: ${widget.testText}",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: const Text("Set light"),
                        onPressed: () => toggleThemeMode(0),
                      ),
                  TextButton(
                    child: const Text("Set dark"),
                    onPressed: () => toggleThemeMode(1),
                  ),
                    ],
                  ),
                  ...colorButtons(themeController),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

