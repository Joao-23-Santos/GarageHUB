import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryContainer = Color(0xFFFFCC00);
  static const Color onPrimaryContainer = Color(0xFF3d2f00);
  static const Color primary = Color(0xFFffedc3);
  static const Color onPrimary = Color(0xFF3d2f00);
  
  static const Color surface = Color(0xFF131313);
  static const Color surfaceContainer = Color(0xFF1f2020);
  static const Color surfaceContainerLow = Color(0xFF1b1c1c);
  static const Color surfaceContainerLowest = Color(0xFF0e0e0e);
  static const Color surfaceContainerHigh = Color(0xFF2a2a2a);
  static const Color surfaceContainerHighest = Color(0xFF353535);
  
  static const Color onSurface = Color(0xFFe5e2e1);
  static const Color onSurfaceVariant = Color(0xFFd2c5ab);
  
  static const Color outline = Color(0xFF9a9078);
  static const Color outlineVariant = Color(0xFF4e4632);
  
  static const Color secondary = Color(0xFFdfc47a);
  static const Color onSecondary = Color(0xFF3d2f00);
  static const Color secondaryContainer = Color(0xFF574504);
  
  static const Color error = Color(0xFFffb4ab);
  static const Color errorContainer = Color(0xFF93000a);
  
  static const Color tertiary = Color(0xFFc6f7ff);
  static const Color tertiaryContainer = Color(0xFF00e7fe);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: surface,
    appBarTheme: const AppBarTheme(
      backgroundColor: surface,
      elevation: 0,
      centerTitle: false,
    ),
    colorScheme: const ColorScheme.dark(
      primary: primaryContainer,
      onPrimary: onPrimaryContainer,
      surface: surface,
      onSurface: onSurface,
      secondary: secondary,
      onSecondary: onSecondary,
      error: error,
      onError: Color(0xFF690005),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w700,
        letterSpacing: -0.02,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w600,
        letterSpacing: -0.01,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceContainerLowest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryContainer, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      labelStyle: const TextStyle(
        fontFamily: 'Manrope',
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.0,
        color: onSurfaceVariant,
      ),
    ),
  );
}
