import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/src/avatars/base_avatar.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpeakerAvatar extends StatelessWidget {
  const SpeakerAvatar({
    required this.speaker,
    this.size = 80,
    this.showFlag = true,
    super.key,
  }) : assert(size > 0, 'Avatar size must be positive');

  final SpeakerSummary speaker;
  final double size;
  final bool showFlag;

  double get _flagSize => size * 0.3;
  double get _flagBorderWidth => _flagSize * 0.1;

  Widget _buildCountryFlag(ColorScheme colorScheme) {
    if (speaker.countryFlagUrl.isEmpty) {
      return _buildFlagPlaceholder(colorScheme);
    }

    return SizedBox.square(
      dimension: _flagSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: _flagBorderWidth),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: ClipOval(
          child: SvgPicture.network(
            speaker.countryFlagUrl,
            width: _flagSize,
            height: _flagSize,
            fit: BoxFit.cover,
            placeholderBuilder:
                (_) => _buildFlagLoadingPlaceholder(colorScheme),
          ),
        ),
      ),
    );
  }

  Widget _buildFlagPlaceholder(ColorScheme colorScheme) {
    return SizedBox.square(
      dimension: _flagSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorScheme.surfaceContainerHigh,
          border: Border.all(color: Colors.white, width: _flagBorderWidth),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Icon(
          Icons.flag_outlined,
          size: _flagSize * 0.5,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildFlagLoadingPlaceholder(ColorScheme colorScheme) {
    return ColoredBox(
      color: colorScheme.surfaceContainer,
      child: Center(
        child: SizedBox.square(
          dimension: _flagSize * 0.5,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            valueColor: AlwaysStoppedAnimation<Color>(
              colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    final semanticLabel =
        'Profile picture of ${speaker.name} from ${speaker.country}';
    final cacheKey = 'speaker_${speaker.id}_${size.toInt()}';

    return Stack(
      clipBehavior: Clip.none,
      children: [
        BaseAvatar(
          imageUrl: speaker.photo,
          cacheKey: cacheKey,
          size: size,
          semanticLabel: semanticLabel,
        ),
        if (showFlag && speaker.countryCode.isNotEmpty)
          Positioned(
            bottom: -(_flagBorderWidth / 2),
            right: -(_flagBorderWidth / 2),
            child: ExcludeSemantics(child: _buildCountryFlag(colorScheme)),
          ),
      ],
    );
  }
}
