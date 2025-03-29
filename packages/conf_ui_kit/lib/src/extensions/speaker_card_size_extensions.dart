import 'package:conf_ui_kit/src/cards/speaker_card.dart';
import 'package:flutter/material.dart';

extension SpeakerCardSizeExtension on SpeakerCardSize {
  double get avatarSize {
    return switch (this) {
      SpeakerCardSize.small => 40,
      SpeakerCardSize.large => 80,
    };
  }

  EdgeInsets get padding {
    return switch (this) {
      SpeakerCardSize.small => const EdgeInsets.all(8),
      SpeakerCardSize.large => const EdgeInsets.all(16),
    };
  }

  TextStyle getTitleStyle(TextTheme textTheme) {
    return switch (this) {
      SpeakerCardSize.small => textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.bold,
      ),
      SpeakerCardSize.large => textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.bold,
      ),
    };
  }
}
