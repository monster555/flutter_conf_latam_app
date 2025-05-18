import 'package:flutter/widgets.dart';

extension LocaleX on BuildContext {
  String get languageCode {
    return Localizations.localeOf(this).languageCode;
  }
}
