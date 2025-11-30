import 'package:flutter/material.dart';
import 'color_schemes.dart';
import 'text_themes.dart';

class AppTheme {
  // Get the default text theme to build upon
  static final TextTheme _baseTextTheme = Typography.material2018().englishLike;

  // The single, public ThemeData instance for the entire application
  static final ThemeData lightTheme = ThemeData(
    // 1. Color Scheme and Primary/Secondary
    primaryColor: primaryColor,
    colorScheme: lightColorScheme,
    
    // 2. Scaffolds/General Background
    scaffoldBackgroundColor: scaffoldBackground,

    // 3. Global Text Theme
    textTheme: buildTextTheme(_baseTextTheme),

    // 4. Component Theming
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: onPrimary, // White text/icons
      elevation: 4,
      centerTitle: true,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: onPrimary,
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),

    
    
    // Input/Form Field Styling
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: secondaryColor, width: 2.0),
      ),
      labelStyle: const TextStyle(color: hintColor),
      hintStyle: const TextStyle(color: hintColor),
    ),
  );
  
  // You would define AppTheme.darkTheme here as well...
}