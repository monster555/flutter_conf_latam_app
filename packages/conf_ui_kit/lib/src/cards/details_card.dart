import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

/// A card that displays key-value information with optional icons.
class DetailsCard extends StatelessWidget {
  /// Creates a card that displays key details with optional icons.
  const DetailsCard({
    required this.title,
    required this.details,
    this.titleStyle,
    this.iconColor,
    super.key,
  });

  /// The title of the details card.
  final String title;

  /// List of detail items to display.
  final List<DetailItem> details;

  /// Optional style for the title text.
  final TextStyle? titleStyle;

  /// Optional color for all icons in the details.
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    final effectiveTitleStyle =
        titleStyle ??
        textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold);
    final effectiveIconColor = iconColor ?? colorScheme.primary;

    return Semantics(
      container: true,
      label: title,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: UiConstants.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              header: true,
              child: Text(title, style: effectiveTitleStyle, softWrap: true),
            ),
            const SizedBox(height: UiConstants.spacing8),
            ...details.map(
              (detail) => Padding(
                padding: const EdgeInsets.only(bottom: UiConstants.spacing8),
                child: MergeSemantics(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (detail.icon != null)
                        Icon(
                          detail.icon,
                          size: UiConstants.iconSizeSmall,
                          color: effectiveIconColor,
                        ),
                      if (detail.icon != null)
                        const ExcludeSemantics(
                          child: SizedBox(width: UiConstants.spacing8),
                        ),
                      Expanded(
                        child: Text(
                          detail.text,
                          style: detail.style ?? textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A single detail item to display in a DetailsCard.
class DetailItem {
  /// Creates a detail item with optional icon and text style.
  const DetailItem({required this.text, this.icon, this.style});

  /// The text to display for this detail.
  final String text;

  /// Optional icon to display before the text.
  final IconData? icon;

  /// Optional style for the text.
  final TextStyle? style;
}
