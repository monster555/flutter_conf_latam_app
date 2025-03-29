import 'package:conf_shared_models/src/enums/enums.dart';
import 'package:conf_shared_models/src/models/session.dart';

class Speaker {
  Speaker({
    required this.id,
    required this.name,
    required this.role,
    required this.country,
    required this.countryCode,
    required this.language,
    required this.bio,
    required this.photo,
    required this.professionalProfiles,
    required this.sessions,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      id: json['id'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      country: json['country'] as String,
      countryCode: json['countryCode'] as String,
      language: Language.values.byName(json['language'] as String),
      bio: json['bio'] as String,
      photo: json['photo'] as String,
      professionalProfiles:
          (json['professionalProfiles'] as List)
              .map((profile) => profile.toString())
              .toList(),
      sessions:
          (json['sessions'] as List<Map<String, dynamic>>)
              .map(Session.fromJson)
              .toList(),
    );
  }

  final String id;
  final String name;
  final String role;
  final String country;
  final String countryCode;
  final Language language;
  final String bio;
  final String photo;
  final List<String> professionalProfiles;
  final List<Session> sessions;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'country': country,
      'countryCode': countryCode,
      'language': language,
      'bio': bio,
      'photo': photo,
      'professionalProfiles': professionalProfiles,
      'sessions': sessions.map((session) => session.toJson()).toList(),
    };
  }
}
