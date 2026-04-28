import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryContainer = Color(0xFFFFCC00);
  static const Color onPrimaryContainer = Color(0xFF3d2f00);
  static const Color primary = Color(0xFFffedc3);
  static const Color onPrimary = Color(0xFF3d2f00);
  static const Color primaryFixed = Color(0xFFffe08b);
  static const Color onPrimaryFixed = Color(0xFF241a00);
  static const Color onPrimaryFixedVariant = Color(0xFF584400);
  static const Color primaryFixedDim = Color(0xFFf1c100);
  
  static const Color surface = Color(0xFF131313);
  static const Color surfaceContainer = Color(0xFF1f2020);
  static const Color surfaceContainerLow = Color(0xFF1b1c1c);
  static const Color surfaceContainerLowest = Color(0xFF0e0e0e);
  static const Color surfaceContainerHigh = Color(0xFF2a2a2a);
  static const Color surfaceContainerHighest = Color(0xFF353535);
  static const Color surfaceBright = Color(0xFF393939);
  static const Color surfaceDim = Color(0xFF131313);
  static const Color surfaceTint = Color(0xFFf1c100);
  
  static const Color onSurface = Color(0xFFe5e2e1);
  static const Color onSurfaceVariant = Color(0xFFd2c5ab);
  
  static const Color outline = Color(0xFF9a9078);
  static const Color outlineVariant = Color(0xFF4e4632);
  
  static const Color secondary = Color(0xFFdfc47a);
  static const Color onSecondary = Color(0xFF3d2f00);
  static const Color secondaryContainer = Color(0xFF574504);
  static const Color onSecondaryContainer = Color(0xFFcdb36a);
  static const Color secondaryFixed = Color(0xFFfde093);
  static const Color secondaryFixedDim = Color(0xFFdfc47a);
  static const Color onSecondaryFixed = Color(0xFF241a00);
  static const Color onSecondaryFixedVariant = Color(0xFF574504);
  
  static const Color error = Color(0xFFffb4ab);
  static const Color errorContainer = Color(0xFF93000a);
  static const Color onErrorContainer = Color(0xFFffdad6);
  
  static const Color tertiary = Color(0xFFc6f7ff);
  static const Color tertiaryContainer = Color(0xFF00e7fe);
  static const Color onTertiaryContainer = Color(0xFF00646e);
  static const Color tertiaryFixed = Color(0xFF95f1ff);
  static const Color tertiaryFixedDim = Color(0xFF00daf0);
  static const Color onTertiary = Color(0xFF00363d);
  static const Color onTertiaryFixed = Color(0xFF001f24);
  static const Color onTertiaryFixedVariant = Color(0xFF004f57);
  
  static const Color background = Color(0xFF131313);
  static const Color onBackground = Color(0xFFe5e2e1);
  static const Color inverseSurface = Color(0xFFe5e2e1);
  static const Color inverseOnSurface = Color(0xFF303030);
  static const Color inversePrimary = Color(0xFF745b00);

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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      labelStyle: const TextStyle(
        fontFamily: 'Space Grotesk',
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
        color: onSecondaryFixedVariant,
      ),
      hintStyle: TextStyle(
        color: outline.withOpacity(0.5),
      ),
    ),
  );
}
