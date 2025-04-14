import 'dart:ui';

import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

/// A widget that applies a frosted glass effect to its child.
///
/// Useful for creating translucent UI elements with a blur effect.
class FrostedGlass extends StatelessWidget {
  /// Creates a frosted glass effect container.
  const FrostedGlass({
    required this.child,
    this.sigma = 10.0,
    this.color,
    this.border,
    this.borderRadius,
    super.key,
  });

  /// The widget to display inside the frosted glass container.
  final Widget child;

  /// Blur intensity (higher = more blur)
  final double sigma;

  /// Background color with opacity
  final Color? color;

  /// Optional border to add to the frosted glass
  final Border? border;

  /// Optional border radius
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ?? context.scaffoldBackgroundColor.withValues(alpha: 0.75);

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: effectiveColor,
            border: border,
            borderRadius: borderRadius,
          ),
          child: child,
        ),
      ),
    );
  }
}
