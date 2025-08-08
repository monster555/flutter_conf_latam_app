import 'package:cached_network_image/cached_network_image.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

/// Base avatar implementation with common avatar functionality.
///
/// This is a private widget used internally by SpeakerAvatar and
/// SessionSpeakerAvatar to avoid code duplication while maintaining clean
/// public APIs.
class BaseAvatar extends StatelessWidget {
  const BaseAvatar({
    required this.imageUrl,
    required this.cacheKey,
    required this.size,
    this.semanticLabel,
    super.key,
  });

  final String imageUrl;
  final String cacheKey;
  final double size;
  final String? semanticLabel;

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

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final placeholder = _buildPlaceholder(colorScheme);

    final avatar = ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child:
          imageUrl.isEmpty
              ? placeholder
              : CachedNetworkImage(
                cacheKey: cacheKey,
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: size,
                height: size,
                fadeInDuration: UiConstants.animationMedium,
                errorWidget: (_, _, _) => placeholder,
              ),
    );

    if (semanticLabel != null) {
      return Semantics(
        label: semanticLabel,
        image: true,
        excludeSemantics: true,
        child: SizedBox.square(dimension: size, child: avatar),
      );
    }

    return SizedBox.square(dimension: size, child: avatar);
  }
}
