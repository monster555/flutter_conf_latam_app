import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

/// A card displaying information with an icon, title, and description.
class InfoCard extends StatelessWidget {
  /// Creates an information card with an icon, title and description.
  const InfoCard({
    required this.title,
    required this.description,
    required this.icon,
    this.iconColor,
    super.key,
  });

  /// The title displayed at the top of the card.
  final String title;

  /// The descriptive text content of the card.
  final String description;

  /// The icon displayed next to the title.
  final IconData icon;

  /// The color of the icon. Defaults to the primary color of the theme.
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Semantics(
      label: title,
      hint: description,
      container: true,
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(UiConstants.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MergeSemantics(
                child: Row(
                  children: [
                    ExcludeSemantics(
                      child: Icon(
                        icon,
                        color: iconColor ?? colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: UiConstants.spacing8),
                    Expanded(
                      child: Semantics(
                        header: true,
                        child: Text(
                          title,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: UiConstants.spacing8),
              Text(description, style: textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
