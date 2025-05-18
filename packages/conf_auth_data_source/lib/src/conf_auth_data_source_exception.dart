/// Base class for all authentication-related exceptions in the data source layer.
sealed class ConfAuthDataSourceException implements Exception {
  /// Creates a [ConfAuthDataSourceException] with an associated message.
  const ConfAuthDataSourceException(this.message);

  /// Description of the error.
  final String message;
}

/// Thrown when the user manually aborts the sign-in process.
final class UserAbortedSignInException extends ConfAuthDataSourceException {
  const UserAbortedSignInException()
      : super('User aborted the sign-in process.');
}

/// Thrown when a Firebase authentication error occurs.
final class FirebaseSignInException extends ConfAuthDataSourceException {
  // ignore: lines_longer_than_80_chars
  /// Creates a [FirebaseSignInException] with an optional error code and a message.
  const FirebaseSignInException({
    required String message,
    this.code,
  }) : super(message);

  /// The Firebase error code associated with this exception, if available.
  final String? code;
}

/// Thrown when an error occurs during the sign-out process.
final class SignOutFailedException extends ConfAuthDataSourceException {
  const SignOutFailedException() : super('Failed to sign out the user.');
}
