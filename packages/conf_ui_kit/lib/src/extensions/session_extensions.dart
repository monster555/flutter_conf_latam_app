import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/src/extensions/session_level_extensions.dart';

/// Extensions for Session domain logic and UI display rules
extension SessionX on Session {
  /// Break session types (coffee, lunch, networking, etc.)
  static const _breakTypes = {
    SessionType.breaks,
    SessionType.lunch,
    SessionType.coffee,
    SessionType.networking,
  };

  /// Administrative session types
  static const _checkInTypes = {SessionType.checkIn};

  /// Special session types (keynotes with different display rules)
  static const _specialTypes = {SessionType.keynote, SessionType.panel};

  /// Sessions without standard metadata display (breaks + admin)
  static const _typesWithoutStandardMetadata = {
    ..._breakTypes,
    ..._checkInTypes,
  };

  /// Sessions without level display (standard + special types)
  static const _typesWithoutLevel = {
    ..._typesWithoutStandardMetadata,
    ..._specialTypes,
  };

  /// Sessions without track display (breaks + admin)
  static const _typesWithoutTrack = {..._breakTypes, ..._checkInTypes};

  /// Non-interactive sessions (breaks + admin)
  static const _nonInteractiveTypes = {..._breakTypes, ..._checkInTypes};

  /// Whether this session is a break (coffee, lunch, networking, etc.)
  bool get isBreak => _breakTypes.contains(type);

  /// Whether this session is interactive (not break or admin)
  bool get isInteractive => !_nonInteractiveTypes.contains(type);

  /// Duration of this session
  Duration get duration => endDate.difference(startDate);

  /// Human-readable duration text (e.g., "1 h 30 min", "45 min")
  String get durationText {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return '$hours h $minutes min';
    } else {
      return '$minutes min';
    }
  }

  /// Formatted speaker display text with count indicator for multiple speakers
  /// Returns: "Speaker Name" or "Speaker Name +2" for multiple speakers
  String get speakersDisplayText {
    if (speakers?.isEmpty ?? true) return '';

    final speakersList = speakers!;
    return speakersList.length > 1
        ? '${speakersList.first.name} +${speakersList.length - 1}'
        : speakersList.first.name;
  }

  /// Whether this session has formatted speaker text to display
  bool get hasSpeakersDisplayText => speakersDisplayText.isNotEmpty;

  String levelText(Map<SessionLevel, String> levelLabels) =>
      levelLabels[level] ?? level!.defaultText;

  /// Whether this session has a description to display
  bool get hasDescription => description?.isNotEmpty ?? false;

  /// Whether this session should display speakers in UI
  bool get shouldDisplaySpeakers {
    if (_typesWithoutStandardMetadata.contains(type)) return false;
    return speakers?.isNotEmpty ?? false;
  }

  /// Whether this session should display level in UI
  bool get shouldDisplayLevel {
    if (level == null) return false;
    if (_typesWithoutLevel.contains(type)) return false;
    return level != null;
  }

  /// Whether this session should display language in UI
  bool get shouldDisplayLanguage =>
      !_typesWithoutStandardMetadata.contains(type) && language != null;

  /// Whether this session should display track in UI
  bool get shouldDisplayTrack => !_typesWithoutTrack.contains(type);

  /// Speakers that should be displayed (filtered and safe)
  List<SessionSpeaker> get displaySpeakers =>
      shouldDisplaySpeakers ? (speakers ?? const []) : const <SessionSpeaker>[];

  /// Whether this session has chip metadata to display (level, language, track)
  /// Excludes speakers which are displayed separately
  bool get hasChipMetadata =>
      shouldDisplayLevel || shouldDisplayLanguage || shouldDisplayTrack;

  /// Whether this session has any metadata to display (including speakers)
  bool get hasMetadataToDisplay => shouldDisplaySpeakers || hasChipMetadata;

  /// Whether this session has any content to display
  bool get hasContentToDisplay => hasMetadataToDisplay || hasDescription;

  /// Icon path for break sessions (null for non-break sessions)
  String? get breakIconPath {
    if (!isBreak) return null;

    return 'assets/icons/agenda/${_getBreakIconKey()}.png';
  }

  String _getBreakIconKey() => switch (type) {
    SessionType.lunch => 'lunch-dash',
    SessionType.networking => 'networking-dash',
    SessionType.coffee => 'networking-dash',
    _ => 'networking-dash',
  };
}
