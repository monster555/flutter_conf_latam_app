import 'package:conf_shared_models/src/models/session.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_slot.g.dart';

@JsonSerializable()
class TimeSlot {
  const TimeSlot({
    required this.id,
    required this.name,
    required this.sessions,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);

  final String id;
  final String name;
  final List<Session> sessions;
}
