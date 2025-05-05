import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/src/chips/color_chip.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:conf_ui_kit/src/utils/date_format_service.dart';
import 'package:flutter/material.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({
    required this.session,
    this.showDescription = false,
    this.levelLabels = const {},
    this.onTap,
    super.key,
  });

  final Session session;
  final bool showDescription;
  final Map<SessionLevel, String> levelLabels;
  final VoidCallback? onTap;

  Widget _buildLevelChip(SessionLevel level) {
    final levelText = levelLabels[level] ?? level.defaultText;

    return ColorChip(
      text: levelText,
      backgroundColor: level.color.withValues(alpha: 0.2),
      textColor: level.color,
    );
  }

  Widget _buildLanguageChip(ColorScheme colorScheme, Language language) {
    return ColorChip(
      text: language.abbreviation,
      backgroundColor: colorScheme.secondary.withValues(alpha: 0.2),
      textColor: colorScheme.secondary,
      icon: Icons.language,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final formatter = DateFormatService.withContext(context);
    final formattedStartTime = formatter.formatTime24Hours(session.startTime);
    final formattedEndTime = formatter.formatTime24Hours(session.endTime);

    final semanticLabel =
        '${session.title}. '
        'From $formattedStartTime to '
        '$formattedEndTime. '
        'Speaker: ${session.mainSpeaker.name}. '
        'Level: ${levelLabels[session.level] ?? session.level.defaultText}. '
        'Language: ${session.language.name}';

    final child = MergeSemantics(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: ExcludeSemantics(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formattedStartTime,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  Text(formattedEndTime, style: textTheme.bodySmall),
                ],
              ),
            ),
          ),

          const ExcludeSemantics(child: SizedBox(width: UiConstants.spacing16)),

          Expanded(
            flex: 10,
            child: ExcludeSemantics(
              child: Padding(
                padding: const EdgeInsets.only(right: UiConstants.spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline,
                          size: UiConstants.spacing16,
                        ),
                        const SizedBox(width: UiConstants.spacing4),
                        Expanded(child: Text(session.mainSpeaker.name)),
                      ],
                    ),
                    const SizedBox(height: UiConstants.spacing4),
                    Row(
                      children: [
                        _buildLevelChip(session.level),
                        const SizedBox(width: UiConstants.spacing8),
                        _buildLanguageChip(colorScheme, session.language),
                      ],
                    ),
                    if (showDescription &&
                        session.description.isNotEmpty == true) ...[
                      const SizedBox(height: UiConstants.spacing8),
                      Text(
                        session.description,
                        style: textTheme.bodySmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        borderRadius: UiConstants.borderRadiusLarge,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: UiConstants.spacing8),
          child: Semantics(
            button: true,
            label: semanticLabel,
            hint: 'Tap to view session details',
            child: child,
          ),
        ),
      );
    } else {
      return Semantics(label: semanticLabel, child: child);
    }
  }
}
