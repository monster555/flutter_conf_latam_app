/// Utility class for normalizing data structures from dynamic sources.
///
/// Handles type conversion and normalization for data coming from JavaScript
/// environments like Cloud Functions, ensuring compatibility with Dart's
/// type system.
class DataNormalizer {
  // Private constructor prevents instantiation
  const DataNormalizer._();

  /// Normalizes a list of maps from a dynamic source.
  ///
  /// Converts JavaScript-style maps with dynamic keys to Dart's
  /// `Map<String, dynamic>` format.
  static List<Map<String, dynamic>> normalizeMapList(dynamic value) {
    if (value == null) return [];
    if (value is! List) return [];

    return value
        .whereType<Map<dynamic, dynamic>>()
        .map(Map<String, dynamic>.from)
        .toList();
  }

  /// Normalizes a list of strings from a dynamic source.
  ///
  /// Ensures all items are strings and filters out null values.
  static List<String> normalizeStringList(dynamic value) {
    if (value == null) return [];
    if (value is! List) return [];

    return value
        .where((item) => item != null)
        .map((item) => item.toString())
        .toList();
  }
}
