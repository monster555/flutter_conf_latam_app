import 'package:conf_shared_models/src/models/speaker.dart';

extension SpeakerX on Speaker {
  String get flagEmoji {
    return countryCode
        .toUpperCase()
        .split('')
        .map((char) => String.fromCharCode(char.codeUnitAt(0) + 127397))
        .join();
  }
}
