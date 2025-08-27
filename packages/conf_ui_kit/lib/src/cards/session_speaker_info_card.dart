import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/src/avatars/session_speaker_avatar.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/info/icon_label.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

class SessionSpeakerInfoCard extends StatelessWidget {
  const SessionSpeakerInfoCard({
    required this.speaker,
    required this.sessionTime,
    required this.track,
    this.onTap,
    super.key,
  });

  final SessionSpeaker speaker;
  final String sessionTime;
  final String track;
  final VoidCallback? onTap;
  static const double _avatarSize = 56;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final isInteractive = onTap != null;

    final semanticLabel =
        isInteractive
            ? 'Speaker ${speaker.name}. Tap to view speaker details.'
            : 'Speaker ${speaker.name}.';

    final content = Padding(
      padding: const EdgeInsets.all(UiConstants.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ExcludeSemantics(
                child: SessionSpeakerAvatar(
                  speaker: speaker,
                  size: _avatarSize,
                ),
              ),
              const SizedBox(width: UiConstants.spacing16),
              Expanded(
                child: ExcludeSemantics(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        speaker.name,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: UiConstants.spacing4),
                      Text(
                        speaker.title,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isInteractive)
                ExcludeSemantics(
                  child: Icon(
                    Icons.chevron_right,
                    color: colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
            ],
          ),
          const SizedBox(height: UiConstants.spacing8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconLabel(icon: Icons.access_time, label: sessionTime),
              const SizedBox(height: UiConstants.spacing4),
              IconLabel(
                icon: Icons.location_on_outlined,
                label: 'Track $track',
              ),
            ],
          ),
        ],
      ),
    );

    return Semantics(
      label: semanticLabel,
      button: isInteractive,
      hint: isInteractive ? 'Tap to view speaker details' : null,
      child: Card(
        color: colorScheme.surface.withValues(alpha: 0.5),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child:
            isInteractive
                ? InkWell(
                  onTap: onTap,
                  borderRadius: UiConstants.borderRadiusLarge,
                  child: content,
                )
                : content,
      ),
    );
  }
}
