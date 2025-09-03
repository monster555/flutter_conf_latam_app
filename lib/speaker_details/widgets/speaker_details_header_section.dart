import 'package:conf_shared_models/conf_shared_models.dart' show SpeakerSummary;
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';

class SpeakerDetailsHeaderSection extends StatelessWidget {
  const SpeakerDetailsHeaderSection({required this.speakerSummary, super.key});

  final SpeakerSummary speakerSummary;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final name = speakerSummary.name;
    final title = speakerSummary.title;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(UiConstants.spacing16),
        child: Row(
          children: [
            SpeakerAvatar(
              speaker: speakerSummary,
              size: UiConstants.avatarSizeXLarge,
            ),
            const SizedBox(width: UiConstants.spacing16),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(title),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
