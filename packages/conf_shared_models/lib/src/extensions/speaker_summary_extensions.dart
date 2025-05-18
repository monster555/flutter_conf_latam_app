import 'package:conf_shared_models/src/models/speaker_summary.dart';

extension SpeakerX on SpeakerSummary {
  String get flagEmoji {
    return countryCode
        .toUpperCase()
        .split('')
        .map((char) => String.fromCharCode(char.codeUnitAt(0) + 127397))
        .join();
  }
}
