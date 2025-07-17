import 'package:conf_shared_models/conf_shared_models.dart'
    show SocialMediaLink;
import 'package:conf_ui_kit/src/constants/package_constants.dart';
import 'package:conf_ui_kit/src/extensions/social_media_link_extensions.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A list item that displays a social network with icon and name.
///
/// Used to show clickable social media links in a vertical list.
class SocialNetworkListItem extends StatelessWidget {
  /// Creates a social network list item.
  const SocialNetworkListItem({
    required this.social,
    required this.onTap,
    super.key,
  });

  /// The social media link to display.
  final SocialMediaLink social;

  /// Called when the button is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    const size = UiConstants.iconSizeXLarge;
    const iconSize = size * 0.6;

    return Semantics(
      button: true,
      label: '${social.displayName} profile',
      hint: social.accessibilityHint,
      child: InkWell(
        onTap: onTap,
        borderRadius: UiConstants.borderRadiusLarge,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(UiConstants.spacing8),
              child: ExcludeSemantics(
                child: SizedBox.square(
                  dimension: size,
                  child: Center(
                    child: SvgPicture.asset(
                      social.iconAssetPath,
                      package: PackageConstants.packageName,
                      width: iconSize,
                      height: iconSize,
                      colorFilter: ColorFilter.mode(
                        colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                      placeholderBuilder:
                          (_) => const Icon(Icons.public, size: iconSize),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    social.displayName,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: UiConstants.spacing2),
                  Text(
                    social.displayUrl,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
