import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/src/cards/session/session_content_section.dart';
import 'package:conf_ui_kit/src/extensions/session_extensions.dart';
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

  static const EdgeInsets _cardPadding = EdgeInsets.symmetric(
    vertical: UiConstants.spacing8,
    horizontal: UiConstants.spacing16,
  );

  final Session session;
  final bool showDescription;
  final Map<SessionLevel, String> levelLabels;
  final VoidCallback? onTap;

  String _buildSemanticLabel(DateFormatter formatter) {
    final formattedStartTime = formatter.formatTime24Hours(session.startDate);
    final formattedEndTime = formatter.formatTime24Hours(session.endDate);

    final buffer = StringBuffer(
      '${session.title}. From $formattedStartTime to $formattedEndTime',
    );

    if (session.shouldDisplaySpeakers) {
      final speakerNames = session.displaySpeakers
          .map((speaker) => speaker.name)
          .join(', ');
      buffer.write('. Speaker: $speakerNames');
    }

    if (session.shouldDisplayLevel) {
      buffer.write('. Level: ${session.levelText(levelLabels)}');
    }

    if (session.shouldDisplayLanguage) {
      buffer.write('. Language: ${session.language?.name}');
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final formatter = DateFormatService.withContext(context);
    final semanticLabel = _buildSemanticLabel(formatter);

    final isInteractive = session.isInteractive && onTap != null;

    final child = MergeSemantics(
      child: ExcludeSemantics(
        child: Padding(
          padding: const EdgeInsets.only(right: UiConstants.spacing16),
          child: SessionContentSection(
            session: session,
            showDescription: showDescription,
            levelLabels: levelLabels,
          ),
        ),
      ),
    );

    if (isInteractive) {
      return Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: InkWell(
          borderRadius: UiConstants.borderRadiusLarge,
          onTap: onTap,
          child: Padding(
            padding: _cardPadding,
            child: Semantics(
              button: true,
              label: semanticLabel,
              hint: 'Tap to view session details',
              child: child,
            ),
          ),
        ),
      );
    } else {
      return Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        color: colorScheme.surface.withValues(alpha: 0.5),
        child: Semantics(
          label: semanticLabel,
          child: Padding(padding: _cardPadding, child: child),
        ),
      );
    }
  }
}
