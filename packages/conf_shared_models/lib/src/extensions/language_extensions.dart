import 'package:conf_shared_models/conf_shared_models.dart';

extension LanguageX on Language {
  String get abbreviation => switch (this) {
    (Language.english) => 'EN',
    (Language.spanish) => 'ES',
  };

  String get fullName => switch (this) {
    (Language.english) => 'English',
    (Language.spanish) => 'Español',
  };
}
