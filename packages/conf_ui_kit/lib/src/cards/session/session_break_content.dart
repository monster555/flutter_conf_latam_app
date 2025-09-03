import 'package:conf_shared_models/conf_shared_models.dart' show Session;
import 'package:conf_ui_kit/src/cards/session/session_description.dart';
import 'package:conf_ui_kit/src/cards/session/session_title.dart';
import 'package:conf_ui_kit/src/extensions/session_extensions.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

class SessionBreakContent extends StatelessWidget {
  const SessionBreakContent({required this.session, super.key});

  final Session session;

  Widget _buildImageWidget(ColorScheme colorScheme) {
    return Image.asset(
      session.breakIconPath!,
      width: UiConstants.iconSizeLarge,
      height: UiConstants.iconSizeLarge,
      errorBuilder: (_, __, ___) {
        return Icon(
          Icons.free_breakfast,
          size: UiConstants.iconSizeLarge,
          color: colorScheme.primary,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    final effectiveRowAlignment =
        session.hasDescription
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center;

    return Row(
      crossAxisAlignment: effectiveRowAlignment,
      children: [
        if (session.breakIconPath != null) ...[
          _buildImageWidget(colorScheme),
          const SizedBox(width: UiConstants.spacing12),
        ],

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SessionTitle(title: session.title),
              if (session.hasDescription)
                SessionDescription(description: session.description!),
            ],
          ),
        ),
      ],
    );
  }
}
