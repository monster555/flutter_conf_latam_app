import 'package:conf_auth_data_source/conf_auth_data_source.dart';
import 'package:conf_shared_models/conf_shared_models.dart';

typedef FutureAuthResult<T> = FutureResult<T, ConfAuthDataSourceException>;

/// Contract for authentication operations at the domain layer.
abstract interface class IConfAuthRepository {
  /// Signs in the user with Google.
  FutureAuthResult<ConfAuthUser> signInWithGoogle();

  /// Signs in the user with Apple.
  FutureAuthResult<ConfAuthUser> signInWithApple();

  /// Signs in the user anonymously.
  FutureAuthResult<ConfAuthUser> signInAnonymously();

  /// Returns the currently signed-in user, or null if no user is signed in.
  ConfAuthUser? get currentUser;

  /// Signs out the current user.
  FutureAuthResult<void> signOut();
}
