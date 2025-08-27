import 'package:conf_shared_models/src/enums/enums.dart';
import 'package:json_annotation/json_annotation.dart';

class SessionLevelConverter implements JsonConverter<SessionLevel?, String?> {
  const SessionLevelConverter();

  @override
  SessionLevel? fromJson(String? json) {
    if (json == null) return null;

    final normalized = json.toLowerCase().trim();

    return switch (normalized) {
      'basic' ||
      'beginner' ||
      'introductory' ||
      'intro' ||
      'starter' => SessionLevel.basic,
      'intermediate' || 'mid' || 'medium' => SessionLevel.intermediate,
      'advanced' => SessionLevel.advanced,
      'expert' || 'senior' || 'master' => SessionLevel.expert,
      'all_audience' || 'general' => SessionLevel.basic,

      _ => SessionLevel.basic,
    };
  }

  @override
  String? toJson(SessionLevel? level) => level?.name;
}
