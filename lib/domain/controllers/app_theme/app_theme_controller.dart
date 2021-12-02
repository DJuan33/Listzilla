import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/UI/themes/colors/dark_colors.dart';
import 'package:listzilla/UI/themes/colors/light_colors.dart';
import 'package:listzilla/UI/themes/dark_theme/listzilla_dark_theme.dart';
import 'package:listzilla/UI/themes/light_theme/listzilla_light_theme.dart';
import 'package:listzilla/UI/themes/listzilla_theme.dart';
import 'package:listzilla/domain/controllers/app_theme/app_theme_state.dart';
import 'package:listzilla/domain/repositories/user_repository.dart';

/// The controller of the global app theme builted with BLoC.
class AppThemeController extends Cubit<AppThemeState> {
  /// User Database connection.
  /// Usually used for saving the theme mode on the user settings.
  final UserRepositoryInterface userDBConnection =
      AppDependencies.dependencyInjector.resolve();

  AppThemeController() : super(AppThemeState.initial);

  /// Returns the `ThemeData` of the current activated Theme.
  ThemeData getTheme() {
    if (userDBConnection.userExists() && !state.themeLoaded ) {
      setThemeMode(userDBConnection.getUserThemeMode());
      emit(state.copyWith(themeLoaded:true));
    }
    return state.currentTheme.getThemeData();
  }

  /// Set the primary color of the app from the given [colorCode].
  void setPrimaryColor(int colorCode) {
    Color newPrimaryColor = getColorFromCode(colorCode, state.themeMode);
    ListzillaTheme newTheme = state.currentTheme.copyWith(
      color: newPrimaryColor,
    );

    emit(
      state.copyWith(
        primaryColor: newPrimaryColor,
        currentTheme: newTheme,
        colorCode: colorCode,
      ),
    );
  }

  /// Set theme mode (dark, light, etc...).
  /// NOTE: With the adition of more themes, the switch will be insufficient.
  void setThemeMode(int value) {
    AppThemeState newState = state.copyWith();

    switch (value) {
      case 0:
        newState = newState.copyWith(
          themeMode: 0,
          currentTheme: LightTheme(
            color: getColorFromCode(newState.colorCode, 0),
          ),
        );
        break;
      case 1:
        newState = newState.copyWith(
          themeMode: 1,
          currentTheme: DarkTheme(
            color: getColorFromCode(newState.colorCode, 1),
          ),
        );
        break;
    }

    userDBConnection.setThemeMode(newState.themeMode);
    emit(newState);
  }

  /// Returns a `Color` from the given [colorCode]
  Color getColorFromCode(int colorCode, int themeMode) {
    Color color = Colors.transparent;

    if (themeMode == 0) {
      color = ListzillaLightColors().getColorFromCode(colorCode);
    } else {
      color = ListzillaDarkColors().getColorFromCode(colorCode);
    }

    return color;
  }
}
