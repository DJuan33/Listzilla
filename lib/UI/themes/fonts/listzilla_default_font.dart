import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListzillaDefaultTextTheme {
  /// The theme primary color.
  Color themePrimaryColor;

  /// The theme brightness.
  ///
  /// 0 for ligth, 1 for dark.
  int themeBrightness;

  ListzillaDefaultTextTheme({
    required this.themePrimaryColor,
    required this.themeBrightness,
  });

  TextTheme getTextTheme() => TextTheme(
        // Used in very large titles like the introduction one.
        headline4: GoogleFonts.encodeSans(
          textStyle: TextStyle(
            color: themePrimaryColor,
            fontSize: 33,
            fontWeight: FontWeight.w600,
          ),
        ),
        // Used in very very large titles like the introduction one.
        headline2: GoogleFonts.encodeSans(
          textStyle: TextStyle(
            color: themePrimaryColor,
            fontSize: 33,
            fontWeight: FontWeight.w600,
          ),
        ),

        // Used in titles.
        subtitle1: GoogleFonts.encodeSans(
          textStyle: TextStyle(
            color: themePrimaryColor,
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
        ),

        // Used in labels.
        bodyText1: GoogleFonts.encodeSans(
          color: themePrimaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
        ),

        // Regular text.
        bodyText2: GoogleFonts.encodeSans(
          color: themeBrightness == 0 ? Colors.black : Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),

        // Button text.
        button: GoogleFonts.encodeSans(
          color: themePrimaryColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      );
}
