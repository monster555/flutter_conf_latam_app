import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/src/assets/image_assets.dart';
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

  final Speaker speaker;
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

    if (speaker.photo.isEmpty) {
      return placeholder;
    }

    return FadeInImage.memoryNetwork(
      placeholder: ImageAssets.kTransparentImage,
      image: speaker.photo,
      fit: BoxFit.cover,
      fadeInDuration: UiConstants.animationMedium,
      imageErrorBuilder: (_, _, _) => placeholder,
      placeholderErrorBuilder: (_, _, _) => placeholder,
      placeholderFit: BoxFit.cover,
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
        'Profile picture of ${speaker.name}'
        '${showFlag && speaker.countryCode.isNotEmpty ? ''
                ' from ${speaker.country}' : ''}';

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
