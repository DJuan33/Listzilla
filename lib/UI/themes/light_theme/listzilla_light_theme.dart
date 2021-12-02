import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listzilla/UI/themes/fonts/listzilla_default_font.dart';
import 'package:listzilla/UI/themes/listzilla_theme.dart';

class LightTheme extends ListzillaTheme {
  /* App primary color */
  final Color color;

  LightTheme({required this.color});

  @override
  ThemeData getThemeData() => ThemeData.light().copyWith(
        // Text theme
        textTheme: ListzillaDefaultTextTheme(
          themePrimaryColor: color,
          themeBrightness: 0,
        ).getTextTheme(),

        // Color and Brightness
        brightness: Brightness.light,
        primaryColor: color,
        colorScheme: const ColorScheme.light().copyWith(
          primary: color,
          secondary: color,
          brightness: Brightness.light,
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
    return LightTheme(color: color ?? this.color);
  }
}
