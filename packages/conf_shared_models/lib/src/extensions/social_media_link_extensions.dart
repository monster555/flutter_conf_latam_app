import 'package:conf_shared_models/src/models/social_media_link.dart';

/// Extension to get icon assets for social media links.
extension SocialMediaIconX on SocialMediaLink {
  /// Returns the asset path for the social media platform icon.
  String get iconAssetPath => 'assets/social_icons/${_getIconKey()}.svg';

  String _getIconKey() {
    final normalized = type.toLowerCase().trim();

    // Special case for X/Twitter
    if (normalized == 'x' || normalized == 'twitter') {
      return 'x';
    }

    return ['linkedin', 'youtube', 'instagram', 'tiktok'].contains(normalized)
        ? normalized
        : 'other';
  }
}
