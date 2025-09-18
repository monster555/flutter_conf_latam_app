/// Base exception for all data source exceptions.
class ConfDataSourceException implements Exception {
  const ConfDataSourceException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() =>
      'ConfDataSourceException: $message${cause != null ? ' ($cause)' : ''}';
}

/// Base class for user-related Cloud Functions errors.
sealed class ConfUserDataSourceException implements Exception {
  const ConfUserDataSourceException();
}

/// Thrown when fetching a user fails.
class ConfGetUserException extends ConfUserDataSourceException {
  const ConfGetUserException([this.message = 'Failed to fetch user.']);
  final String message;

  @override
  String toString() => 'ConfGetUserException: $message';
}

/// Thrown when creating a user fails.
class ConfCreateUserException extends ConfUserDataSourceException {
  const ConfCreateUserException([this.message = 'Failed to create user.']);
  final String message;

  @override
  String toString() => 'ConfCreateUserException: $message';
}
