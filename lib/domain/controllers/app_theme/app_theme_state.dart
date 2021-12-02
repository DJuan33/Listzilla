import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:listzilla/UI/themes/colors/light_colors.dart';
import 'package:listzilla/UI/themes/light_theme/listzilla_light_theme.dart';
import 'package:listzilla/UI/themes/listzilla_theme.dart';

/// This class defines the State for the `AppThemeController`.
@immutable
class AppThemeState extends Equatable {
  /// An integer for store the color code
  /// of the primary color.
  final int colorCode;

  /// This attribute stores the app theme mode:
  ///
  /// ```dart
  /// int themeMode = 0 //for light mode.
  /// int themeMode = 1 //for dark mode.
  ///```
  ///
  /// NOTE: This was builted in this mode for supporting the adition of future themes.
  final int themeMode;

  /// The `Color` type object of the app primary color.
  final Color primaryColor;

  /// The current active theme that implements the [ListzillaTheme] class
  final ListzillaTheme currentTheme;

  /// Indicates if the theme was already loaded from user settings.
  final bool themeLoaded;

  const AppThemeState({
    required this.primaryColor,
    required this.colorCode,
    required this.themeMode,
    required this.currentTheme,
    required this.themeLoaded,
  });

  //@override
  //void onReady() {
  //  _checkData();
  //  super.onReady();
  //}

  //void _checkData() {
  //  String userID = userDBConnection.createInitialUser();
  //  if (userID != "") {
  //    _checkUser();
  //    _checkTheme();
  //  }
  //}

  //void _checkTheme() {
  //  changeThemeMode(userDBConnection.themeMode());
  //}

  //void _checkUser() { */ /*     themeMode = userDBConnection.themeMode();
  //  print("Theme mode: $themeMode");
  //}

  /// Returns a copy of the state with the given fields replaced.
  AppThemeState copyWith({
    int? colorCode,
    int? themeMode,
    Color? primaryColor,
    ListzillaTheme? currentTheme,
    bool? themeLoaded,
  }) {
    return AppThemeState(
      colorCode: colorCode ?? this.colorCode,
      themeMode: themeMode ?? this.themeMode,
      primaryColor: primaryColor ?? this.primaryColor,
      currentTheme: currentTheme ?? this.currentTheme,
      themeLoaded: themeLoaded ?? this.themeLoaded,
    );
  }

  /// Inital state for the [AppThemeController].
  static AppThemeState initial = AppThemeState(
    primaryColor: ListzillaLightColors().getColorFromCode(0),
    themeMode: 0,
    currentTheme: LightTheme(
      color: ListzillaLightColors().getColorFromCode(0),
    ),
    colorCode: 0,
    themeLoaded: false,
  );

  /// Get the list of properties for instance comparison.
  @override
  List<Object?> get props => [
        primaryColor,
        colorCode,
        themeMode,
        currentTheme,
        themeLoaded,
      ];
}
