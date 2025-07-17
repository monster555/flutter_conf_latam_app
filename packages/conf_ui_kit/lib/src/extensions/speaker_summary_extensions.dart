import 'package:conf_shared_models/conf_shared_models.dart' show SpeakerSummary;

extension SpeakerX on SpeakerSummary {
  String get flagEmoji {
    return countryCode
        .toUpperCase()
        .split('')
        .map((char) => String.fromCharCode(char.codeUnitAt(0) + 127397))
        .join();
  }
}
