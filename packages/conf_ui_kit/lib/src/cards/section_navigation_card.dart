import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

/// A navigational card that directs users to a specific section of the app.
///
/// Displays a title, description, and icon with tap functionality.
class SectionNavigationCard extends StatelessWidget {
  const SectionNavigationCard({
    required this.title,
    required this.description,
    required this.onTap,
    this.assetPath,
    super.key,
  });

  static const _indicatorSize = 48.0;

  final String title;
  final String description;
  final VoidCallback onTap;
  final String? assetPath;

  /// Builds the visual indicator widget (asset or icon).
  Widget _buildIndicator(ColorScheme colorScheme) {
    // Prioritize asset path over icon
    if (assetPath != null) {
      return Image.asset(
        assetPath!,
        // Fallback to icon if asset fails to load
        errorBuilder: (_, _, _) => _buildIconWidget(colorScheme),
      );
    }

    return _buildIconWidget(colorScheme);
  }

  /// Builds the fallback icon widget.
  Widget _buildIconWidget(ColorScheme colorScheme) =>
      Icon(Icons.apps, size: _indicatorSize, color: colorScheme.primary);

  Widget _buildContent(TextTheme textTheme) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: UiConstants.spacing4),
          Text(
            description,
            style: textTheme.bodyMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Semantics(
      button: true,
      label: title,
      hint: description,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: UiConstants.spacing8),
        child: Card(
          margin: EdgeInsets.zero,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(UiConstants.spacing12),
            child: Padding(
              padding: const EdgeInsets.all(UiConstants.spacing16),
              child: Row(
                children: [
                  ExcludeSemantics(child: _buildIndicator(colorScheme)),
                  const SizedBox(width: UiConstants.spacing16),
                  _buildContent(textTheme),
                  const SizedBox(width: UiConstants.spacing8),
                  Icon(
                    Icons.adaptive.arrow_forward,
                    color: colorScheme.primary,
                    size: UiConstants.iconSizeSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
