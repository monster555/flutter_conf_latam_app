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
}
