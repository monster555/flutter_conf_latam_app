import 'package:conf_shared_models/conf_shared_models.dart'
    show Session, SessionLevel;
import 'package:conf_ui_kit/src/chips/session_language_chip.dart';
import 'package:conf_ui_kit/src/chips/session_level_chip.dart';
import 'package:conf_ui_kit/src/extensions/session_extensions.dart';
import 'package:conf_ui_kit/src/extensions/session_level_extensions.dart';
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
    return Padding(
      padding: const EdgeInsets.only(bottom: UiConstants.spacing8),
      child: Row(
        children: [
          if (session.shouldDisplayLanguage)
            SessionLanguageChip(language: session.language),
          if (session.shouldDisplayLevel) ...[
            if (session.shouldDisplayLanguage)
              const SizedBox(width: UiConstants.spacing8),
            SessionLevelChip(
              level: session.displayLevel!,
              labelText:
                  levelLabels[session.displayLevel] ??
                  session.displayLevel!.defaultText,
            ),
          ],
        ],
      ),
    );
  }
}
