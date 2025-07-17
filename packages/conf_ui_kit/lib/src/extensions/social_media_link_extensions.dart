import 'package:conf_shared_models/conf_shared_models.dart'
    show SocialMediaLink;
import 'package:conf_ui_kit/src/localization/ui_kit_localizations.dart'
    show UiKitLocalizations;

/// Provides UI-specific extensions for social media links.
///
/// Handles display names, accessibility hints, and other UI concerns
/// while respecting localization settings.
extension SocialMediaLinkX on SocialMediaLink {
  UiKitLocalizations get _localizations => UiKitLocalizations();

  /// Returns a user-friendly display version of the URL without protocol.
  /// Example: https://github.com/username → github.com/username
  String get displayUrl {
    try {
      final uri = Uri.parse(link);
      var display = uri.host;
      if (uri.path.isNotEmpty && uri.path != '/') {
        display += uri.path;
      }
      return display;
    } on FormatException catch (_) {
      // Fallback if URL parsing fails
      return link.split('//').lastOrNull ?? link;
    }
  }

  /// Returns the display name of the social media platform.
  String get displayName {
    // Normalize type for case-insensitive comparison
    final normalizedType = type.toLowerCase().trim();

    return switch (normalizedType) {
      'github' => 'GitHub',
      'linkedin' => 'LinkedIn',
      'youtube' => 'YouTube',
      'x' || 'twitter' => 'X',
      'instagram' => 'Instagram',
      'tiktok' => 'TikTok',
      _ => _localizations.socialNetworkOther,
    };
  }

  /// Returns an accessibility hint describing what happens when tapping
  /// this link.
  String get accessibilityHint =>
      '${_localizations.socialNetworkAccessibilityHint}$displayName';

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
