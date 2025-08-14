import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/src/avatars/speaker_avatar.dart';
import 'package:conf_ui_kit/src/extensions/speaker_card_size_extensions.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

enum SpeakerCardSize { small, large }

class SpeakerCard extends StatelessWidget {
  const SpeakerCard({
    required this.speaker,
    this.onTap,
    this.showBio = true,
    this.maxBioLines = 2,
    this.cardSize = SpeakerCardSize.large,
    super.key,
  });

  final SpeakerSummary speaker;
  final VoidCallback? onTap;
  final bool showBio;
  final int maxBioLines;
  final SpeakerCardSize cardSize;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final semanticLabel =
        '${speaker.name}. '
        'Title: ${speaker.title}.';

    return Semantics(
      label: semanticLabel,
      button: onTap != null,
      hint: onTap != null ? 'Tap to view speaker details' : null,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: cardSize.padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpeakerAvatar(speaker: speaker, size: cardSize.avatarSize),
                const SizedBox(width: UiConstants.spacing16),
                Expanded(
                  child: ExcludeSemantics(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          speaker.name,
                          style: cardSize.getTitleStyle(textTheme),
                        ),
                        Text(
                          speaker.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
