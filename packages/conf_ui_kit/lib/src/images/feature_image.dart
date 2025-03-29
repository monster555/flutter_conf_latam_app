import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

/// A component for displaying feature images with consistent styling.
class FeatureImage extends StatelessWidget {
  /// Creates a feature image with consistent styling.
  const FeatureImage({
    required this.imagePath,
    this.borderRadius = UiConstants.radiusLarge,
    this.semanticLabel,
    this.padding = const EdgeInsets.only(top: 16),
    super.key,
  });

  /// The path to the image asset.
  final String imagePath;

  /// The border radius for the image corners. Defaults to 16.
  final double borderRadius;

  /// Optional semantic label for accessibility.
  final String? semanticLabel;

  /// Optional padding around the image. Defaults to top padding of 16.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final effectiveLabel = semanticLabel ?? 'Feature Image';

    return Padding(
      padding: padding,
      child: Semantics(
        image: true,
        label: effectiveLabel,
        excludeSemantics: true,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
