import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

/// A reusable widget that displays an icon followed by text
class IconLabel extends StatelessWidget {
  const IconLabel({
    required this.icon,
    required this.label,
    this.iconSize = UiConstants.iconSizeSmall,
    this.spacing = UiConstants.spacing4,
    this.style,
    this.iconColor,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.maxLines,
    this.overflow,
    super.key,
  });

  /// The icon to display
  final IconData icon;

  /// The text label to display
  final String label;

  /// Size of the icon
  final double iconSize;

  /// Horizontal spacing between icon and label
  final double spacing;

  /// Text style for the label
  final TextStyle? style;

  /// Color for the icon
  final Color? iconColor;

  /// Cross axis alignment for the row
  final CrossAxisAlignment crossAxisAlignment;

  /// Maximum lines for text
  final int? maxLines;

  /// Text overflow behavior
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Icon(icon, size: iconSize, color: iconColor),
          SizedBox(width: spacing),
          Flexible(
            child: Text(
              label,
              style: style ?? context.textTheme.bodyMedium,
              maxLines: maxLines,
              overflow: overflow,
            ),
          ),
        ],
      ),
    );
  }
}
