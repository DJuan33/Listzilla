import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:listzilla/UI/themes/colors/listzilla_colors.dart';

class ListzillaLightColors extends ListzillaColors {
  final Color color0 = Colors.indigo;
  final Color color1 = Colors.red;
  final Color color2 = Colors.green;
  final Color color3 = Colors.cyan;
  final Color color4 = Colors.deepOrange;
  final Color color5 = Colors.pink;
  final Color color6 = Colors.amber.shade800;
  final Color color7 = Colors.teal;
  final Color color8 = Colors.deepPurple;

  @override
  Color getColorFromCode(int colorCode) {
    Color selectedColor = color0;

    switch (colorCode) {
      case 0:
        break;

      case 1:
        selectedColor = color1;
        break;

      case 2:
        selectedColor = color2;
        break;

      case 3:
        selectedColor = color3;
        break;

      case 4:
        selectedColor = color4;
        break;

      case 5:
        selectedColor = color5;
        break;

      case 6:
        selectedColor = color6;
        break;

      case 7:
        selectedColor = color7;
        break;

      case 8:
        selectedColor = color8;
        break;
    }

    return selectedColor;
  }

  @override
  List<Color> getColorScheme() {
    return [color0,color1,color2,color3,color4,color5,color6,color7,color8];
  }
}
