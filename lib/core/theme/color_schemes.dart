import 'package:flutter/material.dart';

// --- Primary Colors ---
const Color primaryColor = Color(0xFF6200EE); // Deep Purple
const Color primaryDark = Color(0xFF3700B3); 
const Color primaryLight = Color(0xFFBB86FC); 

// --- Secondary/Accent Colors ---
const Color secondaryColor = Color(0xFF03DAC6); // Teal Accent
const Color secondaryDark = Color(0xFF018786);

// --- Background and Surface Colors ---
const Color scaffoldBackground = Color(0xFFF5F5F5); // Light Gray
const Color surfaceColor = Colors.white; // Card/Widget background

// --- Text and Status Colors ---
const Color errorColor = Colors.redAccent;
const Color onPrimary = Colors.white; // Color of text/icons on primaryColor
const Color onSecondary = Colors.black; // Color of text/icons on secondaryColor
const Color onSurface = Colors.black87; // Default text color on card/surface
const Color hintColor = Colors.grey;

// You can define your full LightColorScheme here for easy access
const ColorScheme lightColorScheme = ColorScheme(
  primary: primaryColor,
  primaryContainer: primaryLight,
  secondary: secondaryColor,
  secondaryContainer: secondaryDark,
  surface: surfaceColor,
  error: errorColor,
  onPrimary: onPrimary,
  onSecondary: onSecondary,
  onSurface: onSurface,
  onError: onPrimary,
  brightness: Brightness.light,
);