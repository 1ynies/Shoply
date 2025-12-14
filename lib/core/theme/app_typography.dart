// lib/core/theme/app_typography.dart
import 'package:flutter/material.dart';
import 'app_pallete.dart'; // Import your colors if needed for specific text overrides

class AppTypography {
  const AppTypography._();

  static const String fontFamily = 'Poppins'; // Or whatever font you use

  static TextTheme get textTheme {
    return const TextTheme(
      // High emphasis - Large titles
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppPallete.midnightBlue,
      ),
      // Medium emphasis - Subtitles
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppPallete.midnightBlue,
      ),
      // Low emphasis - Captions/Small text
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.grey,
      ),
    );
  }
}