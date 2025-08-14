import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/src/avatars/speaker_avatar.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:conf_ui_kit/src/typography/section_title.dart';
import 'package:flutter/material.dart';

/// A horizontal scrollable list of featured speakers
class SpeakersSection extends StatelessWidget {
  /// Creates a speakers section
  const SpeakersSection({
    required this.sectionTitle,
    required this.speakers,
    required this.onSpeakerTap,
    super.key,
  });

  static const EdgeInsets _itemPadding = EdgeInsets.symmetric(
    horizontal: UiConstants.spacing2,
  );

  /// Title for the section
  final String sectionTitle;

  /// List of speakers to display
  final List<SpeakerSummary> speakers;

  /// Called when a speaker is tapped
  final void Function(SpeakerSummary speaker) onSpeakerTap;

  @override
  Widget build(BuildContext context) {
    if (speakers.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: sectionTitle),
          const SizedBox(height: UiConstants.spacing8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final speaker in speakers)
                  Padding(
                    padding: _itemPadding,
                    child: _SpeakerItem(
                      speaker: speaker,
                      onTap: () => onSpeakerTap(speaker),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SpeakerItem extends StatelessWidget {
  const _SpeakerItem({required this.speaker, required this.onTap});

  static const Widget _verticalSpacing = SizedBox(height: UiConstants.spacing8);

  static const EdgeInsets _speakerNamePadding = EdgeInsets.symmetric(
    vertical: UiConstants.spacing8,
  );

  final SpeakerSummary speaker;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Semantics(
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: UiConstants.borderRadiusLarge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpeakerAvatar(speaker: speaker),
            _verticalSpacing,
            Padding(
              padding: _speakerNamePadding,
              child: SizedBox(
                width: UiConstants.speakerCardWidth,
                child: Text(
                  speaker.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
