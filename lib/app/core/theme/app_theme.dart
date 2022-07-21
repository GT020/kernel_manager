import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const Color appGreen = Color(0xFFDCFC34);
const Color appBlue = Color(0xFF21E8E4);
const Color appLightGray = Color(0xFF4B4C5A);
const Color appDarkGray = Color(0xFF2F2F3D);

class AppTheme {
  final newDarkThemeData = ThemeData(
    useMaterial3: true,
    primaryTextTheme: const TextTheme(
      headline1: TextStyle(
        color: appBlue,
      ),
      headline2: TextStyle(
        color: appBlue,
      ),
      headline3: TextStyle(
        color: appBlue,
      ),
      headline4: TextStyle(
        color: appBlue,
      ),
      headline5: TextStyle(
        color: appBlue,
      ),
      headline6: TextStyle(
        color: appBlue,
      ),
      subtitle1: TextStyle(
        color: appBlue,
      ),
      subtitle2: TextStyle(
        color: appBlue,
      ),
      bodyText1: TextStyle(
        color: appBlue,
      ),
      bodyText2: TextStyle(
        color: appBlue,
      ),
      button: TextStyle(
        color: appBlue,
      ),
      caption: TextStyle(
        color: appBlue,
      ),
    ),
    primaryColor: appGreen,
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
