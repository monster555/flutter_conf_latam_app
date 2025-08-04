import 'package:conf_shared_models/conf_shared_models.dart' show SessionSpeaker;
import 'package:conf_ui_kit/src/avatars/base_avatar.dart';
import 'package:flutter/material.dart';

/// A simplified avatar for session speakers without country flag support.
///
/// SessionSpeaker objects don't include country information, so this avatar
/// displays only the speaker's photo without flag overlay.
class SessionSpeakerAvatar extends StatelessWidget {
  const SessionSpeakerAvatar({required this.speaker, this.size = 80, super.key})
    : assert(size > 0, 'Avatar size must be positive');

  final SessionSpeaker speaker;
  final double size;

  @override
  Widget build(BuildContext context) {
    final cacheKey = 'session_speaker_${speaker.id}_${size.toInt()}';
    final semanticLabel = 'Profile picture of ${speaker.name}';

    return BaseAvatar(
      imageUrl: speaker.imageUrl,
      cacheKey: cacheKey,
      size: size,
      semanticLabel: semanticLabel,
    );
  }
}
