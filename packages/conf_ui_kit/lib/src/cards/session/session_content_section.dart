import 'package:conf_shared_models/conf_shared_models.dart'
    show Session, SessionLevel;
import 'package:conf_ui_kit/src/cards/session/session_description.dart';
import 'package:conf_ui_kit/src/cards/session/session_metadata_chips.dart';
import 'package:conf_ui_kit/src/cards/session/session_speakers.dart';
import 'package:conf_ui_kit/src/cards/session/session_title.dart';
import 'package:conf_ui_kit/src/extensions/session_extensions.dart';
import 'package:flutter/material.dart';

class SessionContentSection extends StatelessWidget {
  const SessionContentSection({
    required this.session,
    required this.showDescription,
    required this.levelLabels,
    super.key,
  });

  final Session session;
  final bool showDescription;
  final Map<SessionLevel, String> levelLabels;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SessionTitle(session: session),
        if (session.shouldDisplaySpeakers)
          SessionSpeakers(speakers: session.displaySpeakers),
        if (session.shouldDisplayLevel || session.shouldDisplayLanguage)
          SessionMetadataChips(session: session, levelLabels: levelLabels),
        if (showDescription && (session.description?.isNotEmpty ?? false))
          SessionDescription(description: session.description!),
      ],
    );
  }
}
