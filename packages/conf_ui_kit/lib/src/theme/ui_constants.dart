import 'package:flutter/material.dart';

/// Constants for UI measurements and values
///
/// This class centralizes common UI constants used throughout the app
/// to ensure consistency in spacing, sizing, and other visual elements.
abstract class UiConstants {
  /// Spacing constants
  static const double spacing2 = 2;
  static const double spacing4 = 4;
  static const double spacing8 = 8;
  static const double spacing12 = 12;
  static const double spacing16 = 16;
  static const double spacing24 = 24;
  static const double spacing32 = 32;

  /// Typography - Font sizes
  static const double fontSizeSmall = 12;
  static const double fontSizeXLarge = 20;
  static const double fontSizeDisplay = 32;

  /// Icon sizes
  static const double iconSizeXSmall = 12;
  static const double iconSizeSmall = 16;
  static const double iconSizeMedium = 24;
  static const double iconSizeXLarge = 48;

  /// Border radius constants
  static const double radiusMedium = 12;
  static const double radiusLarge = 16;

  /// Card and component sizes
  static const double avatarSizeXLarge = 120;
  static const double speakerCardWidth = 100;

  /// Predefined BorderRadius objects
  static final borderRadiusMedium = BorderRadius.circular(radiusMedium);
  static final borderRadiusLarge = BorderRadius.circular(radiusLarge);

  /// Animation durations
  static const Duration animationXShort = Duration(milliseconds: 80);
  static const Duration animationShort = Duration(milliseconds: 150);
  static const Duration animationMedium = Duration(milliseconds: 250);
  static const Duration animationXLong = Duration(milliseconds: 500);

  /// Line and border dimensions
  static const double borderWidth = 1;
  static const double dividerheight = 24;
}
