import 'package:conf_auth_data_source/conf_auth_data_source.dart';
import 'package:conf_auth_repository/conf_auth_repository.dart';
import 'package:conf_shared_models/conf_shared_models.dart';

class ConfAuthRepository implements IConfAuthRepository {
  ConfAuthRepository({required ConfAuthDataSource authDataSource})
      : _authDataSource = authDataSource;

  final ConfAuthDataSource _authDataSource;

  @override
  ConfAuthUser? get currentUser {
    return switch (_authDataSource.currentUser) {
      final AuthUser user => user.confAuthUser,
      null => null,
    };
  }

  @override
  FutureAuthResult<ConfAuthUser> signInAnonymously() async {
    try {
      final user = await _authDataSource.signInAnonymously();
      return Success(user.confAuthUser);
    } on ConfAuthDataSourceException catch (e) {
      return Failure(e);
    }
  }

  @override
  FutureAuthResult<ConfAuthUser> signInWithApple() async {
    try {
      final user = await _authDataSource.signInWithApple();
      return Success(user.confAuthUser);
    } on ConfAuthDataSourceException catch (e) {
      return Failure(e);
    }
  }

  @override
  FutureAuthResult<ConfAuthUser> signInWithGoogle() async {
    try {
      final user = await _authDataSource.signInWithGoogle();
      return Success(user.confAuthUser);
    } on ConfAuthDataSourceException catch (e) {
      return Failure(e);
    }
  }

  @override
  FutureAuthResult<void> signOut() async {
    try {
      await _authDataSource.signOut();
      return const Success(null);
    } on ConfAuthDataSourceException catch (e) {
      return Failure(e);
    }
  }
}

extension on AuthUser {
  ConfAuthUser get confAuthUser => ConfAuthUser(
        id: id,
        email: email,
        displayName: displayName,
        isAnonymous: isAnonymous,
        photoUrl: photoUrl,
      );
}
