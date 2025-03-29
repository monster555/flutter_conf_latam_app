import 'package:conf_ui_kit/src/feedback/feedback_widget.dart';
import 'package:flutter/material.dart';

class SliverFeedbackWidget extends StatelessWidget {
  const SliverFeedbackWidget({
    required this.message,
    this.type = FeedbackType.empty,
    this.icon,
    this.actionLabel,
    this.onAction,
    this.fullscreen = false,
    this.semanticLabel,
    super.key,
  });

  final String message;
  final FeedbackType type;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool fullscreen;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: FeedbackWidget(
        message: message,
        type: type,
        icon: icon,
        actionLabel: actionLabel,
        onAction: onAction,
        fullScreen: fullscreen,
        semanticLabel: semanticLabel,
      ),
    );
  }
}
