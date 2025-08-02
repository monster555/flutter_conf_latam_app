import 'package:flutter/foundation.dart';

/// A test model specifically for verifying the withCache utility.
///
/// Provides a concrete type with JSON serialization to test that generic
/// caching operations correctly preserve data structure and values.
@immutable
class TestModel {
  const TestModel({required this.name, required this.count});

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(name: json['name'] as String, count: json['count'] as int);
  }
  final String name;
  final int count;

  Map<String, dynamic> toJson() {
    return {'name': name, 'count': count};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          count == other.count;

  @override
  int get hashCode => name.hashCode ^ count.hashCode;
}
