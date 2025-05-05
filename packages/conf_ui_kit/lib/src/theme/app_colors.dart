import 'package:flutter/material.dart';

/// Color palette for FlutterConf LATAM app
abstract class AppColors {
  // Primary Flutter blue colors
  static const Color flutterNavy = Color(0xFF042B59);
  static const Color flutterBlue = Color(0xFF0553B1);
  static const Color flutterSky = Color(0xFF027DFD);

  // Light theme colors
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Color(0xFFE0E0E0);
  static const Color lightCardBackground = Color(0xFFE6E6E6);
  static const Color lightText = Color(0xD1000000);

  // Dark theme colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF424242);
  static const Color darkCardBackground = Color(0xFF232323);
  static const Color darkText = Color(0xD9FFFFFF);

  // Semantic colors
  static const Color onPrimary = Colors.white;
  static const Color onPrimaryDark = Colors.black;
  static const Color onSecondary = Colors.white;
  static const Color onSecondaryDark = Colors.black;

  // Helper method to get theme-specific colors
  static ColorScheme lightColorScheme() => const ColorScheme.light(
    primary: flutterNavy,
    secondary: flutterBlue,
    surface: lightSurface,
    onSecondary: onSecondary,
    onSurface: lightText,
  );

  static ColorScheme darkColorScheme() => const ColorScheme.dark(
    primary: flutterSky,
    secondary: flutterBlue,
    surface: darkSurface,
    onSurface: darkText,
  );
}
