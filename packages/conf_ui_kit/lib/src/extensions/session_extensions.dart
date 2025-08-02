import 'package:conf_shared_models/conf_shared_models.dart';

extension SessionX on Session {
  Duration get duration => endTime.difference(startTime);

  String get durationText {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return '$hours h $minutes min';
    } else {
      return '$minutes min';
    }
  }
}
