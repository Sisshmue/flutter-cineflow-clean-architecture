import 'package:cineflow/core/theme/pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData cineFlowTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Pallete.background,
    primaryColor: Pallete.primaryRed,

    appBarTheme: AppBarTheme(backgroundColor: Pallete.background),

    cardTheme: const CardThemeData(color: Pallete.surface, elevation: 4),
    colorScheme: const ColorScheme.dark(
      primary: Pallete.primaryRed,
      secondary: Pallete.accentGold,
      surface: Pallete.surface,
      error: Pallete.error,
      onPrimary: Pallete.textPrimary,
      onSurface: Pallete.textPrimary,
    ),

    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Pallete.textPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      bodyLarge: TextStyle(color: Pallete.textPrimary, fontSize: 16),
      bodyMedium: TextStyle(color: Pallete.textSecondary, fontSize: 14),
    ),
  );
}
