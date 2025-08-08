import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

class ColorChip extends StatelessWidget {
  const ColorChip({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    super.key,
    this.icon,
  });

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colorChipTheme = context.colorChipTheme;

    return MergeSemantics(
      child: Semantics(
        label: text,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor.withValues(
              alpha: colorChipTheme.backgroundOpacity,
            ),
            borderRadius: UiConstants.borderRadiusMedium,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: UiConstants.spacing8,
              vertical: UiConstants.spacing4,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  ExcludeSemantics(
                    child: Icon(
                      icon,
                      size: UiConstants.iconSizeXSmall,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(width: UiConstants.spacing4),
                ],
                ExcludeSemantics(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: UiConstants.fontSizeSmall,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
