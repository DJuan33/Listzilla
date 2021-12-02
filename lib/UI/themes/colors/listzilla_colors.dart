import 'package:flutter/material.dart';

/// Abstract class for color handling
/// of the different in-app themes.
abstract class ListzillaColors {


  /// Returns a `Color` type object from the given [colorCode].
  Color getColorFromCode(int colorCode);

  /// Returns the list of all colors
  List<Color> getColorScheme();
}
