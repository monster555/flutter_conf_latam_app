import 'package:conf_shared_models/conf_shared_models.dart';

extension SessionX on Session {
  static const _typesWithoutSpeakers = {
    SessionType.breaks,
    SessionType.breakTime,
    SessionType.checkIn,
  };

  static const _typesWithoutLevel = {
    SessionType.breaks,
    SessionType.breakTime,
    SessionType.checkIn,
    SessionType.keynote,
  };

  static const _typesWithoutLanguage = {
    SessionType.breaks,
    SessionType.breakTime,
    SessionType.checkIn,
  };

  static const _nonInteractiveTypes = {
    SessionType.breaks,
    SessionType.breakTime,
    SessionType.checkIn,
  };

  Duration get duration => endDate.difference(startDate);

  String get durationText {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return '$hours h $minutes min';
    } else {
      return '$minutes min';
    }
  }

  bool get shouldDisplayLanguage => !_typesWithoutLanguage.contains(type);

  bool get shouldDisplaySpeakers {
    if (_typesWithoutSpeakers.contains(type)) return false;
    return speakers?.isNotEmpty ?? false;
  }

  bool get shouldDisplayLevel {
    if (_typesWithoutLevel.contains(type)) return false;
    return level != null;
  }

  List<SessionSpeaker> get displaySpeakers =>
      shouldDisplaySpeakers ? speakers! : const <SessionSpeaker>[];

  SessionLevel? get displayLevel => shouldDisplayLevel ? level : null;

  bool get hasMetadataToDisplay =>
      shouldDisplaySpeakers || shouldDisplayLevel || shouldDisplayLanguage;

  bool get hasContentToDisplay =>
      shouldDisplaySpeakers ||
      shouldDisplayLevel ||
      (description?.isNotEmpty ?? false);

  bool get isInteractive => !_nonInteractiveTypes.contains(type);
}
