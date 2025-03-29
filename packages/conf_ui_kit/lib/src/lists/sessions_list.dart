import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/src/cards/session_card.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:conf_ui_kit/src/utils/date_format_service.dart';
import 'package:flutter/material.dart';

class SessionsList extends StatelessWidget {
  const SessionsList({
    required this.sessions,
    required this.noSessionsMessage,
    this.sessionLevelLabels = const {},
    this.showSessionDescriptions = false,
    this.onSessionTap,
    this.hideWhenEmpty = false,
    super.key,
  });

  final List<Session> sessions;
  final Map<SessionLevel, String> sessionLevelLabels;
  final String noSessionsMessage;
  final bool showSessionDescriptions;
  final void Function(Session)? onSessionTap;
  final bool hideWhenEmpty;

  Widget _buildEmptyState(ColorScheme colorScheme, TextTheme textTheme) {
    return SliverToBoxAdapter(
      child: Semantics(
        label: noSessionsMessage,
        child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(UiConstants.spacing24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ExcludeSemantics(
                  child: Icon(
                    Icons.event_busy,
                    size: UiConstants.iconSizeXLarge,
                    color: colorScheme.primary.withValues(alpha: 0.5),
                  ),
                ),
                const ExcludeSemantics(
                  child: SizedBox(height: UiConstants.spacing16),
                ),
                Text(
                  noSessionsMessage,
                  style: textTheme.titleSmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSessionsList(List<Session> sessions) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: UiConstants.spacing8),
      sliver: SliverList.separated(
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];
          final startTimeFormatted = DateFormatService.formatTime(
            session.startTime,
            context,
          );

          return Semantics(
            button: true,
            label:
                '${session.title} at $startTimeFormatted '
                'by ${session.speaker.name}',
            hint: 'Tap to view session details',
            child: SessionCard(
              session: session,
              levelLabels: sessionLevelLabels,
              showDescription: showSessionDescriptions,
              onTap: () => onSessionTap?.call(session),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return ExcludeSemantics(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UiConstants.spacing16,
              ),
              child: Divider(
                height: UiConstants.spacing16,
                color: context.colorScheme.primary.withValues(alpha: 0.5),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty && hideWhenEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverMainAxisGroup(
      slivers: [
        if (sessions.isEmpty)
          _buildEmptyState(context.colorScheme, context.textTheme)
        else
          _buildSessionsList(sessions),
      ],
    );
  }
}
