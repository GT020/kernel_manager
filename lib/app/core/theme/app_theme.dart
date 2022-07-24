import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const Color appGreenYellow = Color(0xFFB6FF00);
const Color appLightBlue = Color(0xFF21E8E4);
const Color appLightGray = Color(0xFF4B4C5A);
const Color appDarkGray = Color(0xFF2F2F3D);
const Color appViolet = Color(0xFF7E52FF);
const Color appArsenic = Color(0xFF242834);
const Color appOrange = Color(0xFFFF5B28);
const Color appIrisPurple = Color(0xFF4E4AC6);
const Color appSeaBlue = Color(0xFF43A1ED);

class AppTheme {
  final newDarkThemeData = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      headline1: TextStyle(color: appLightBlue),
      headline2: TextStyle(color: appLightBlue),
      headline3: TextStyle(color: appLightBlue),
      headline4: TextStyle(color: appLightBlue),
      headline5: TextStyle(color: appLightBlue),
      headline6: TextStyle(color: appLightBlue),
      subtitle1: TextStyle(color: appLightBlue),
      subtitle2: TextStyle(color: appLightBlue),
      bodyText1: TextStyle(color: appLightBlue),
      bodyText2: TextStyle(color: appLightBlue),
      caption: TextStyle(color: appLightBlue),
      button: TextStyle(color: appLightBlue),
      overline: TextStyle(color: appLightBlue),
    ),
    primaryColor: appGreenYellow,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: appLightGray,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: appLightGray,
    ),
    cardTheme: const CardTheme(
      clipBehavior: Clip.antiAlias,
      color: appDarkGray,
      elevation: 2,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: appGreenYellow,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  ThemeData get lightTheme {
    return newDarkThemeData;
  }

  /// for getting dark theme
  ThemeData get darkTheme {
    return newDarkThemeData;
  }
}

/// for providing app theme [AppTheme]
final appThemeProvider = Provider<AppTheme>((final _) => AppTheme());
