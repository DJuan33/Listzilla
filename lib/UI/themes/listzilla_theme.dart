import 'package:flutter/material.dart';

/// Abstract class for defining the app themes.
abstract class ListzillaTheme {
  
  /// Returs the ThemeData of the app.
  ThemeData getThemeData();

  /// Returns a copy of the class with the given fields replaced.
  ListzillaTheme copyWith({Color color});
}
