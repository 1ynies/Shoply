import 'package:flutter/material.dart';
import 'color_schemes.dart'; // Import colors for use in styles

// A helper function to create our custom TextTheme
TextTheme buildTextTheme(TextTheme base) {
  return base.copyWith(
    // Headline for large titles (e.g., screen title, product name)
    headlineLarge: base.headlineLarge?.copyWith(
      fontWeight: FontWeight.bold,
      color: primaryColor, // Using color from color_schemes
    ),
    // Title for standard sections
    titleLarge: base.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      color: onSurface,
      fontSize: 20.0,
    ),
    // Body text for general content
    bodyLarge: base.bodyLarge?.copyWith(
      fontSize: 16.0,
      color: onSurface,
    ),
    // Smaller body text (e.g., product description, greyed out text)
    bodyMedium: base.bodyMedium?.copyWith(
      fontSize: 14.0,
      color: hintColor,
    ),
    // Button text
    labelLarge: base.labelLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
    ),
  );
}