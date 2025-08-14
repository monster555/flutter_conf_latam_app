import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

/// A list of details items, each with text and an optional icon.
class IconLabelList extends StatelessWidget {
  /// Creates a list of details items with text and optional icons.
  const IconLabelList({
    required this.items,
    this.spacing = 8.0,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  /// The list of detail items to display.
  final List<IconLabelItem> items;

  /// Vertical spacing between items. Defaults to 8.0.
  final double spacing;

  /// Optional padding around the entire list.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: 'List of details',
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < items.length; i++) ...[
              if (i > 0) SizedBox(height: spacing),
              _IconLabelRow(item: items[i]),
            ],
          ],
        ),
      ),
    );
  }
}

class _IconLabelRow extends StatelessWidget {
  const _IconLabelRow({required this.item});

  final IconLabelItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Semantics(
      label: item.text,
      excludeSemantics: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.icon != null) ...[
            Icon(item.icon, size: UiConstants.iconSizeSmall),
            const SizedBox(width: UiConstants.spacing8),
          ],
          Expanded(
            child: Text(item.text, style: item.style ?? textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

/// A single detail item with text and an optional icon.
class IconLabelItem {
  /// Creates a detail item with text and an optional icon.
  const IconLabelItem({required this.text, this.icon, this.style});

  /// The text to display.
  final String text;

  /// Optional icon to display before the text.
  final IconData? icon;

  /// Optional text style.
  final TextStyle? style;
}
