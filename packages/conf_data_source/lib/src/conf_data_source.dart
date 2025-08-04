abstract class ConfDataSource {
  /// Retrieves all speakers with optional localization
  Future<List<Map<String, dynamic>>> getSpeakers({String? languageCode});

  /// Retrieves a specific speaker by ID with optional localization
  Future<Map<String, dynamic>?> getSpeakerById(
    String id, {
    String? languageCode,
  });

  /// Retrieves all sessions with optional localization
  Future<List<Map<String, dynamic>>> getSessions({String? languageCode});

  /// Retrieves all sponsors
  Future<List<Map<String, dynamic>>> getSponsors();
}
