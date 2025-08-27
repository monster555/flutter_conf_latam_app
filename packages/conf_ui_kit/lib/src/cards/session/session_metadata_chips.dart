import 'package:conf_shared_models/conf_shared_models.dart'
    show Session, SessionLevel;
import 'package:conf_ui_kit/src/chips/session_language_chip.dart';
import 'package:conf_ui_kit/src/chips/session_level_chip.dart';
import 'package:conf_ui_kit/src/chips/session_track_chip.dart';
import 'package:conf_ui_kit/src/extensions/session_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

class SessionMetadataChips extends StatelessWidget {
  const SessionMetadataChips({
    required this.session,
    required this.levelLabels,
    super.key,
  });

  final Session session;
  final Map<SessionLevel, String> levelLabels;

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[];

    if (session.shouldDisplayTrack) {
      chips.add(SessionTrackChip(track: session.track));
    }

    if (session.shouldDisplayLanguage) {
      chips.add(SessionLanguageChip(language: session.language!));
    }

    if (session.shouldDisplayLevel) {
      chips.add(
        SessionLevelChip(
          level: session.level!,
          labelText: session.levelText(levelLabels),
        ),
      );
    }

    if (chips.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: UiConstants.spacing8),
      child: Semantics(
        label: 'Session information',
        child: Wrap(
          spacing: UiConstants.spacing8,
          runSpacing: UiConstants.spacing4,
          children: chips,
        ),
      ),
    );
  }
}
