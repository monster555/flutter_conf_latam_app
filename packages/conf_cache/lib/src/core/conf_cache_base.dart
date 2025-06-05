/// A service that provides caching capabilities for conference data.
///
/// Handles storing and retrieving data with automatic expiration handling.
abstract class ConfCache {
  /// Store raw JSON string with expiration tracking
  Future<void> putString(String key, String jsonData, {Duration? maxAge});

  /// Retrieve raw JSON string if not expired
  Future<String?> getString(String key);

  /// Delete specific cache entry
  Future<void> delete(String key);

  /// Clear all cache entries
  Future<void> clear();
}
