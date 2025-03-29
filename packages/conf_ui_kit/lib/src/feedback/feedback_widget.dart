import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

enum FeedbackType { empty, error, noResults }

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({
    required this.message,
    this.type = FeedbackType.empty,
    this.icon,
    this.actionLabel,
    this.onAction,
    this.fullScreen = false,
    this.semanticLabel,
    super.key,
  });

  final String message;
  final FeedbackType type;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool fullScreen; // Whether to display as full screen or inline
  final String? semanticLabel; // Custom semantic label, falls back to message

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    // Determine icon based on type if not provided
    final effectiveIcon = icon ?? _getDefaultIconForType(type);

    final Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          effectiveIcon,
          size: UiConstants.iconSizeXLarge,
          color: colorScheme.primary.withValues(alpha: 0.5),
        ),
        const SizedBox(height: UiConstants.spacing16),
        Text(
          message,
          style: textTheme.titleSmall?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
        if (actionLabel != null && onAction != null) ...[
          const SizedBox(height: UiConstants.spacing16),
          ElevatedButton(onPressed: onAction, child: Text(actionLabel!)),
        ],
      ],
    );

    final Widget feedbackWidget = Semantics(
      label: semanticLabel ?? message,
      button: onAction != null,
      child:
          fullScreen
              ? Center(child: content)
              : Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(UiConstants.spacing24),
                  child: content,
                ),
              ),
    );

    return feedbackWidget;
  }

  IconData _getDefaultIconForType(FeedbackType type) {
    switch (type) {
      case FeedbackType.empty:
        return Icons.inbox_outlined;
      case FeedbackType.error:
        return Icons.error_outline;
      case FeedbackType.noResults:
        return Icons.search_off;
    }
  }
}
