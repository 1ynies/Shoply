// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'app_pallete.dart';
import 'app_typography.dart';

class AppTheme {
  const AppTheme._();

  // Define the Color Scheme (Mapping Brand Colors to Material Roles)
  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppPallete.burntOrange, // Your brand color becomes 'primary'
    onPrimary: AppPallete.pureWhite, // Text on top of primary
    secondary: AppPallete.midnightBlue,
    onSecondary: AppPallete.pureWhite,
    surface: AppPallete.softGrey,
    onSurface: AppPallete.midnightBlue,
    error: AppPallete.errorRed,
    onError: AppPallete.pureWhite,
  );

  // The Master Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      textTheme: AppTypography.textTheme, // Hooking up the typography
      
      // OPTIONAL: Global Component Styles
      // This is where you set default button shapes, input borders, etc.
      scaffoldBackgroundColor: AppPallete.softGrey,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPallete.burntOrange,
          foregroundColor: AppPallete.pureWhite,
        ),
      ),
    );
  }
}