import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppTheme {
  /// for getting light theme
  ThemeData get lightTheme {
    return FlexThemeData.light(
      scheme: FlexScheme.material,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 20,
      appBarOpacity: 0.95,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        blendOnColors: false,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
    );
  }

  /// for getting dark theme
  ThemeData get darkTheme {
    return FlexThemeData.dark(
      scheme: FlexScheme.material,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 15,
      appBarStyle: FlexAppBarStyle.background,
      appBarOpacity: 0.9,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 30,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
    );
  }
}

/// for providing app theme [AppTheme]
final appThemeProvider = Provider<AppTheme>((final _) => AppTheme());
