import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listzilla/UI/themes/fonts/listzilla_default_font.dart';
import 'package:listzilla/UI/themes/listzilla_theme.dart';

/// The basic dark theme of Listzilla.
class DarkTheme extends ListzillaTheme {
  /// The `Color` type object for the primary color of the app.
  final Color color;

  DarkTheme({required this.color});

  @override
  ThemeData getThemeData() => ThemeData.dark().copyWith(
        // Text theme
        textTheme: ListzillaDefaultTextTheme(
          themePrimaryColor: color,
          themeBrightness: 1,
        ).getTextTheme(),

        // Color and Brightness.
        brightness: Brightness.dark,
        primaryColor: color,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: color,
          secondary: color,
          brightness: Brightness.dark,
        ),

        // App bar theme.
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          foregroundColor: color,
          color: Colors.transparent,
          titleTextStyle: GoogleFonts.encodeSans(
            textStyle: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      );

  @override
  ListzillaTheme copyWith({Color? color}) {
    return DarkTheme(
      color: color ?? this.color,
    );
  }
}
