import 'package:conf_shared_models/src/models/time_slot.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_day.g.dart';

@JsonSerializable()
class ScheduleDay {
  const ScheduleDay({
    required this.id,
    required this.day,
    required this.date,
    required this.slots,
  });

  factory ScheduleDay.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDayFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleDayToJson(this);

  final String id;
  final int day;
  final DateTime date;
  final List<TimeSlot> slots;
}
