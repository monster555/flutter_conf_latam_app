import 'package:conf_shared_models/conf_shared_models.dart' show Language;
import 'package:flutter/widgets.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';

extension LanguageExtensions on Language {
  String getLocalizedName(BuildContext context) {
    final l10n = context.l10n;
    return switch (this) {
      Language.english => l10n.languageEnglish,
      Language.spanish => l10n.languageSpanish,
    };
  }
}

extension LanguageListExtensions on List<Language> {
  /// Formats a list of languages with proper conjunctions.
  String formatList(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;

    final names = map((lang) => lang.getLocalizedName(context)).toList();

    return _formatWithConjunctions(names, locale, l10n);
  }

  /// Helper to format list with proper conjunctions.
  static String _formatWithConjunctions(
    List<String> items,
    String locale,
    AppLocalizations l10n,
  ) {
    if (items.isEmpty) return '';
    if (items.length == 1) return items.first;

    final isSpanish = locale.startsWith('es');
    final lastWord = items.last;
    final conjunction =
        isSpanish ? _getSpanishConjunction(lastWord) : l10n.conjunctionAnd;

    if (items.length == 2) {
      return '${items.first} $conjunction $lastWord';
    } else {
      final allButLast = items.sublist(0, items.length - 1).join(', ');
      return '$allButLast $conjunction $lastWord';
    }
  }

  static String _getSpanishConjunction(String nextWord) {
    return nextWord.toLowerCase().startsWith('i') ? 'e' : 'y';
  }
}
