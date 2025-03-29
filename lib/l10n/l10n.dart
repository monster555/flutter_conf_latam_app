import 'package:flutter/widgets.dart';
import 'package:flutter_conf_latam/l10n/generated/app_localizations.dart';

export 'generated/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
