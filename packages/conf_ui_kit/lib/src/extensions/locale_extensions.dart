import 'package:flutter/widgets.dart';

extension LocaleX on BuildContext {
  String get localeLanguageCode {
    return Localizations.localeOf(this).languageCode;
  }
}
