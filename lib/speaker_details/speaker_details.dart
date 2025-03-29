import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';

class SpeakerDetailsPage extends StatelessWidget {
  const SpeakerDetailsPage(this.speaker, {super.key});

  final Speaker speaker;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = context.textTheme;
    final topContentOffset = context.padding.top + kToolbarHeight;
    final speaksText = l10n.speaks;
    final languageText = speaker.language.fullName;
    final fullLanguageText = '$speaksText: $languageText';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const FrostedAppBar(),
      body: Semantics(
        label: speaker.name,
        container: true,
        explicitChildNodes: true,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: topContentOffset)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(UiConstants.spacing16),
                child: Row(
                  children: [
                    SpeakerAvatar(
                      speaker: speaker,
                      size: UiConstants.avatarSizeXLarge,
                      showFlag: false,
                    ),
                    const ExcludeSemantics(
                      child: SizedBox(width: UiConstants.spacing16),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            speaker.name,
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(speaker.role),

                          MergeSemantics(
                            child: Row(
                              children: [
                                Semantics(
                                  label: l10n.countryFlag(speaker.country),
                                  child: Text(
                                    speaker.flagEmoji,
                                    style: const TextStyle(
                                      fontSize: UiConstants.fontSizeXLarge,
                                    ),
                                  ),
                                ),
                                const ExcludeSemantics(
                                  child: SizedBox(width: UiConstants.spacing4),
                                ),
                                Text(speaker.country),
                              ],
                            ),
                          ),

                          Semantics(
                            label: fullLanguageText,
                            excludeSemantics: true,
                            child: Text(fullLanguageText),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(UiConstants.spacing16),
                child: Text(speaker.bio),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
