import 'package:conf_shared_models/conf_shared_models.dart' show SpeakerSummary;
import 'package:conf_ui_kit/conf_ui_kit.dart'
    show SpeakerLanguagesCard, UiConstants;
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/extensions/language_extensions.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';

class SpeakerDetailsLanguagesSection extends StatelessWidget {
  const SpeakerDetailsLanguagesSection({
    required this.speakerSummary,
    super.key,
  });

  final SpeakerSummary speakerSummary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final languagesText = speakerSummary.languages.formatList(context);

    if (languagesText.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(UiConstants.spacing16),
        child: SpeakerLanguagesCard(
          promptText: l10n.dontBeShyLabel,
          languagesPrefix: l10n.iSpeakPrefix,
          languagesList: languagesText,
        ),
      ),
    );
  }
}
