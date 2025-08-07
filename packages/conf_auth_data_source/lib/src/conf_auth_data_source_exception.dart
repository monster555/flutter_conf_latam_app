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
  /// Creates a [FirebaseSignInException] with an optional error code
  /// and a message.
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

/// Thrown when there is no internet connection.
final class NoInternetException extends ConfAuthDataSourceException {
  const NoInternetException() : super('No internet connection available.');
}

/// Thrown when Sign in with Apple is not available on the current device/platform.
final class AppleSignInNotAvailableException
    extends ConfAuthDataSourceException {
  const AppleSignInNotAvailableException()
      : super('Sign in with Apple is not available on this device.');
}

/// Thrown when an error occurs during the Apple sign-in process.
final class AppleSignInFailedException extends ConfAuthDataSourceException {
  /// Creates an [AppleSignInFailedException] with an optional error code.
  const AppleSignInFailedException({
    required String message,
    this.code,
  }) : super(message);

  /// The Apple sign-in error code associated with this exception, if available.
  final String? code;
}

/// Thrown when the email is already associated with a different sign-in method.
final class AccountExistsWithDifferentCredentialException
    extends ConfAuthDataSourceException {
  const AccountExistsWithDifferentCredentialException({
    required String message,
    required this.email,
  }) : super(message);

  /// The email that already exists in Firebase.
  final String email;
}
