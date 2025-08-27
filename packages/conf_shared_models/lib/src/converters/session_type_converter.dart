import 'package:conf_shared_models/src/enums/enums.dart';
import 'package:json_annotation/json_annotation.dart';

class SessionTypeConverter implements JsonConverter<SessionType, String> {
  const SessionTypeConverter();

  @override
  SessionType fromJson(String json) {
    final normalized = json
        .toLowerCase()
        .trim()
        .replaceAll('-', '')
        .replaceAll('_', '');

    return switch (normalized) {
      'checkin' => SessionType.checkIn,
      'keynote' => SessionType.keynote,
      'session' => SessionType.session,
      'workshop' => SessionType.workshop,
      'breaks' => SessionType.breaks,
      'lunch' => SessionType.lunch,
      'coffee' => SessionType.coffee,
      'networking' => SessionType.networking,
      'panel' => SessionType.panel,
      'finish' => SessionType.finish,

      'break' || 'coffeebreak' => SessionType.breaks,
      'talk' || 'presentation' || 'lecture' => SessionType.session,
      'registration' || 'signin' => SessionType.checkIn,
      'closing' || 'end' || 'goodbye' => SessionType.finish,
      'roundtable' || 'discussion' => SessionType.panel,
      'breakfast' || 'dinner' || 'meal' => SessionType.lunch,
      'social' || 'mixer' => SessionType.networking,

      _ => SessionType.session,
    };
  }

  @override
  String toJson(SessionType type) => type.name;
}
