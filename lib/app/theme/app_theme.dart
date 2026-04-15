import 'package:flutter/material.dart';
import 'package:textile_markaz/app/theme/app_colors.dart';

ThemeData buildAppTheme() {
  final scheme = ColorScheme.light(
    primary: AppColors.primaryclr,
    onPrimary: Colors.white,
    secondary: AppColors.primaryclr,
    onSecondary: Colors.white,
    tertiary: AppColors.accentRed,
    onTertiary: Colors.white,
    surface: AppColors.webSurface,
    onSurface: AppColors.primaryclr,
    onSurfaceVariant: AppColors.mutedText,
    outline: AppColors.outline,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.webSurface,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryclr,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),
    cardTheme: const CardThemeData(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: AppColors.mutedText),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.accentRed, width: 2),
      ),
    ),
  );
}

