import 'package:conf_shared_models/conf_shared_models.dart' show Speaker;
import 'package:conf_ui_kit/conf_ui_kit.dart' show UiConstants;
import 'package:flutter/material.dart';

class SpeakerDetailsDescriptionSection extends StatelessWidget {
  const SpeakerDetailsDescriptionSection({super.key, this.speakerDetails});

  final Speaker? speakerDetails;

  @override
  Widget build(BuildContext context) {
    final description = speakerDetails?.description;
    if (description == null || description.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(UiConstants.spacing16),
        child: Text(description),
      ),
    );
  }
}
