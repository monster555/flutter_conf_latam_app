import 'package:conf_shared_models/conf_shared_models.dart'
    show Session, SessionLevel;
import 'package:conf_ui_kit/src/cards/session/session_break_content.dart';
import 'package:conf_ui_kit/src/cards/session/session_regular_content.dart';
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
    return session.isBreak
        ? SessionBreakContent(session: session)
        : SessionRegularContent(
          session: session,
          showDescription: showDescription,
          levelLabels: levelLabels,
        );
  }
}
