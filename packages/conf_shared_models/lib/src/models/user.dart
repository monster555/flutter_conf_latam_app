import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.name,
    required this.surname,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  final String id;
  final String name;
  final String surname;
  final String? avatar;
}

extension UserX on User? {
  String get safeName => _slug(this?.name, fallback: 'user');
  String get safeLastName => _slug(this?.surname, fallback: 'surname');

  String safeShareFilename({int? year}) {
    final y = year ?? DateTime.now().year;
    return '$safeName-$safeLastName-flutterconf-latam-$y.png';
  }
}

String _slug(String? value, {required String fallback}) {
  final base = (value ?? fallback).trim().toLowerCase();

  final hyphened = base.replaceAll(RegExp('[^a-z0-9]+'), '-');

  final collapsed = hyphened.replaceAll(RegExp('-+'), '-');

  final trimmed = collapsed.replaceAll(RegExp(r'^-+|-+$'), '');

  return trimmed.isEmpty ? fallback : trimmed;
}
