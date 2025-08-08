import 'package:conf_shared_models/conf_shared_models.dart' show SessionSpeaker;
import 'package:conf_ui_kit/src/avatars/session_speaker_avatar.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

/// Simple card for displaying additional session speakers.
///
/// Used to show co-presenters or additional speakers in session details.
/// Does not include session information (time/track) as that context
/// is provided by the main SessionSpeakerInfoCard.
class SessionSpeakerCard extends StatelessWidget {
  const SessionSpeakerCard({required this.speaker, this.label, super.key});

  final SessionSpeaker speaker;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    final semanticLabel =
        label != null
            ? 'Additional speaker ${speaker.name}, ${label!}'
            : 'Additional speaker ${speaker.name}';

    return Semantics(
      label: semanticLabel,
      child: Card(
        color: colorScheme.surface.withValues(alpha: 0.5),
        child: Padding(
          padding: const EdgeInsets.all(UiConstants.spacing12),
          child: Row(
            children: [
              SessionSpeakerAvatar(speaker: speaker, size: 48),
              const SizedBox(width: UiConstants.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(speaker.name, style: textTheme.titleSmall),
                    if (label != null) ...[
                      const SizedBox(height: UiConstants.spacing2),
                      Text(
                        label!,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
