import 'package:flutter/material.dart';

ThemeData 









buildAppTheme() {
  const navy = Color(0xFF112037);
  const accentRed = Color(0xFFBB1943);
  const webSurface = Color(0xFFF3F3F3);
  const mutedText = Color(0xFF777777);

  final scheme = ColorScheme.light(
    primary: navy,
    onPrimary: Colors.white,
    secondary: navy,
    onSecondary: Colors.white,
    tertiary: accentRed,
    onTertiary: Colors.white,
    surface: webSurface,
    onSurface: navy,
    onSurfaceVariant: mutedText,
    outline: const Color(0xFFDDDDDD),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: webSurface,
    appBarTheme: const AppBarTheme(
      backgroundColor: navy,
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
      hintStyle: const TextStyle(color: mutedText),
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
        borderSide: const BorderSide(color: accentRed, width: 2),
      ),
    ),
  );
}
