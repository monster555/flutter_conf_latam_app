// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleDay _$ScheduleDayFromJson(Map<String, dynamic> json) => ScheduleDay(
  id: json['id'] as String,
  day: (json['day'] as num).toInt(),
  date: DateTime.parse(json['date'] as String),
  slots: (json['slots'] as List<dynamic>)
      .map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ScheduleDayToJson(ScheduleDay instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'date': instance.date.toIso8601String(),
      'slots': instance.slots,
    };
