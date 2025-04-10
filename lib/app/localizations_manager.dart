import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:intl/intl.dart';

/// Manages localization for UI components
abstract class LocalizationsManager {
  /// Initialize with default localizations
  static void initialize() {
    UiKitLocalizations.initialize(
      sessionLevelLabels: {
        SessionLevel.basic: 'Basic',
        SessionLevel.intermediate: 'Intermediate',
        SessionLevel.advanced: 'Advanced',
        SessionLevel.expert: 'Expert',
      },
      noSessionsMessageBuilder: (date) {
        final formattedDate = DateFormat.yMMMd().format(date);
        return 'No sessions scheduled for $formattedDate';
      },
    );
  }

  /// Updates UI Kit localizations based on current context
  static void updateWithContext(BuildContext context) {
    final l10n = context.l10n;

    UiKitLocalizations.initialize(
      sessionLevelLabels: {
        SessionLevel.basic: l10n.sessionLevelBasic,
        SessionLevel.intermediate: l10n.sessionLevelIntermediate,
        SessionLevel.advanced: l10n.sessionLevelAdvanced,
        SessionLevel.expert: l10n.sessionLevelExpert,
      },
      noSessionsMessageBuilder: (date) {
        final formatter = DateFormatService.withContext(context);
        final formattedDate = formatter.formatFullDate(date);
        return l10n.errorSessionsNoneForDay(formattedDate);
      },
    );
  }
}
