import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

/// Provides localized strings for the UI Kit components
class UiKitLocalizations {
  /// Access the current instance (with fallback if not initialized)
  factory UiKitLocalizations() {
    return _instance ?? UiKitLocalizations.fallback();
  }

  /// Default localization fallback
  factory UiKitLocalizations.fallback() {
    return UiKitLocalizations._(
      sessionLevelLabels: {
        for (final level in SessionLevel.values) level: level.defaultText,
      },
      noSessionsMessageBuilder: (date) {
        final formatter = DateFormat.yMMMMd();
        return 'No sessions scheduled for ${formatter.format(date)}';
      },
      socialNetworkOther: 'Other',
      socialNetworkAccessibilityHint: 'Opens profile link',
    );
  }
  UiKitLocalizations._({
    required this.sessionLevelLabels,
    required this.noSessionsMessageBuilder,
    required this.socialNetworkOther,
    required this.socialNetworkAccessibilityHint,
  });
  static UiKitLocalizations? _instance;

  /// Labels for session difficulty levels
  final Map<SessionLevel, String> sessionLevelLabels;

  /// Function to build a "no sessions" message with formatted date
  final String Function(DateTime) noSessionsMessageBuilder;

  final String socialNetworkOther;
  final String socialNetworkAccessibilityHint;

  /// Initialize with localized strings from main app
  static void initialize({
    required Map<SessionLevel, String> sessionLevelLabels,
    required String Function(DateTime) noSessionsMessageBuilder,
    required String socialNetworkOther,
    required String socialNetworkAccessibilityHint,
  }) {
    _instance = UiKitLocalizations._(
      sessionLevelLabels: sessionLevelLabels,
      noSessionsMessageBuilder: noSessionsMessageBuilder,
      socialNetworkOther: socialNetworkOther,
      socialNetworkAccessibilityHint: socialNetworkAccessibilityHint,
    );
    if (kDebugMode) {
      print('UiKitLocalizations initialized');
    }
  }
}
