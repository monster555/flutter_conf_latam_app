import 'package:cached_network_image/cached_network_image.dart';
import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

class SpeakerAvatar extends StatelessWidget {
  const SpeakerAvatar({
    required this.speaker,
    this.size = 80,
    this.showFlag = true,
    super.key,
  });

  final SpeakerSummary speaker;
  final double size;
  final bool showFlag;

  Widget _buildPlaceholder(ColorScheme colorScheme) {
    return ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.person,
        size: size * 0.4,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildSpeakerImage(ColorScheme colorScheme) {
    final placeholder = _buildPlaceholder(colorScheme);

    if (speaker.photo.isEmpty) return placeholder;

    final cacheKey = 'speaker_${speaker.id}-${size.toInt()}';

    return CachedNetworkImage(
      cacheKey: cacheKey,
      imageUrl: speaker.photo,
      fit: BoxFit.cover,
      width: size,
      height: size,
      fadeInDuration: UiConstants.animationMedium,
      errorWidget: (_, _, _) => placeholder,
    );
  }

  Widget _buildFlagEmoji() {
    return Text(
      speaker.flagEmoji,
      style: const TextStyle(
        fontSize: UiConstants.iconSizeMedium,
        shadows: [Shadow(color: Colors.white, blurRadius: 8)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    final semanticLabel =
        'Profile picture of ${speaker.name} from ${speaker.country}';

    return Semantics(
      label: semanticLabel,
      image: true, // Identifies this as an image to screen readers
      excludeSemantics: true,
      child: SizedBox.square(
        dimension: size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(size / 2),
              child: _buildSpeakerImage(colorScheme),
            ),

            if (showFlag && speaker.countryCode.isNotEmpty)
              Positioned(bottom: -8, right: 0, child: _buildFlagEmoji()),
          ],
        ),
      ),
    );
  }
}
