import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Theme extension that provides consistent chip styling across the app.
///
/// This extension ensures all chips maintain consistent opacity, contrast,
/// and styling that adapts properly to light and dark themes.
class ColorChipTheme extends ThemeExtension<ColorChipTheme> {
  /// Creates an instance of [ColorChipTheme] with the specified styling values.
  const ColorChipTheme({
    required this.backgroundOpacity,
    required this.textColorAdjustment,
  });

  /// Opacity applied to chip background colors for proper contrast.
  final double backgroundOpacity;

  /// Factor for adjusting text color contrast (0.0 to 1.0).
  final double textColorAdjustment;

  @override
  ThemeExtension<ColorChipTheme> copyWith({
    double? backgroundOpacity,
    double? textColorAdjustment,
  }) {
    return ColorChipTheme(
      backgroundOpacity: backgroundOpacity ?? this.backgroundOpacity,
      textColorAdjustment: textColorAdjustment ?? this.textColorAdjustment,
    );
  }

  @override
  ThemeExtension<ColorChipTheme> lerp(
    covariant ColorChipTheme? other,
    double t,
  ) {
    if (other == null) return this;

    return ColorChipTheme(
      backgroundOpacity:
          lerpDouble(backgroundOpacity, other.backgroundOpacity, t) ??
          backgroundOpacity,
      textColorAdjustment:
          lerpDouble(textColorAdjustment, other.textColorAdjustment, t) ??
          textColorAdjustment,
    );
  }

  /// Light theme chip styling - optimized for light backgrounds
  static const light = ColorChipTheme(
    backgroundOpacity: 0.15,
    textColorAdjustment: 0.4,
  );

  /// Dark theme chip styling - optimized for dark backgrounds
  static const dark = ColorChipTheme(
    backgroundOpacity: 0.25,
    textColorAdjustment: 0.3,
  );
}
