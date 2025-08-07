import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:conf_auth_data_source/conf_auth_data_source.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

String _generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

String _sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

typedef AuthUser = ({
  String id,
  String? email,
  String? displayName,
  String? photoUrl,
  bool isAnonymous,
});

/// DataSource to handle authentication operations using Firebase.
class ConfAuthDataSource {
  /// Creates an instance of [ConfAuthDataSource].
  ConfAuthDataSource({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ??
            GoogleSignIn(
              clientId: const String.fromEnvironment('googleClientId'),
            );
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  /// Signs in the user using Google authentication.
  ///
  /// Throws [UserAbortedSignInException] if the user cancels the login.
  /// Throws [FirebaseSignInException] for any Firebase-related error.
  Future<AuthUser> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw const UserAbortedSignInException();
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final user = (await _signInWithCredential(credential)).user;
      if (user == null) {
        throw const FirebaseSignInException(
          code: 'null-user',
          message: 'No user was returned after signing in with Google.',
        );
      }
      return user.toAuthUser();
    } on SocketException {
      throw const NoInternetException();
    } on FirebaseAuthException catch (e) {
      throw FirebaseSignInException(
        code: e.code,
        message: e.message ?? 'Unknown Firebase error during Google sign-in.',
      );
    }
  }

  /// Signs in the user using Apple authentication.
  ///
  /// Throws [FirebaseSignInException] for any Firebase-related error.
  Future<AuthUser> signInWithApple() async {
    try {
      final available = await SignInWithApple.isAvailable();
      if (!available) {
        throw const FirebaseSignInException(
          message: 'Sign in with Apple is not available on this device.',
        );
      }

      final rawNonce = _generateNonce();
      final hashedNonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: AppleIDAuthorizationScopes.values,
        nonce: hashedNonce,
      );

      final credential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      final user = (await _signInWithCredential(credential)).user;
      if (user == null) {
        throw const FirebaseSignInException(
          code: 'null-user',
          message: 'No user was returned after signing in with Apple.',
        );
      }
      return user.toAuthUser();
    } on SocketException {
      throw const NoInternetException();
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        throw const UserAbortedSignInException();
      }
      throw AppleSignInFailedException(
        code: e.code.name,
        message: e.message,
      );
    } on FirebaseAuthException catch (e) {
      throw FirebaseSignInException(
        code: e.code,
        message: e.message ?? 'Unknown Firebase error during Apple sign-in.',
      );
    }
  }

  /// Signs in the user anonymously.
  ///
  /// Throws [FirebaseSignInException] for any Firebase-related error.
  Future<AuthUser> signInAnonymously() async {
    try {
      final result = await _firebaseAuth.signInAnonymously();
      final user = result.user;
      if (user == null) {
        throw const FirebaseSignInException(
          code: 'null-user',
          message: 'No user was returned after anonymous sign-in.',
        );
      }
      return user.toAuthUser();
    } on SocketException {
      throw const NoInternetException();
    } on FirebaseAuthException catch (e) {
      throw FirebaseSignInException(
        code: e.code,
        message:
            e.message ?? 'Unknown Firebase error during anonymous sign-in.',
      );
    }
  }

  /// Signs out the current user from Firebase and Google (if applicable).

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } on SocketException {
      throw const NoInternetException();
    } on Exception {
      throw const SignOutFailedException();
    }
  }

  /// Returns the currently signed-in user.
  AuthUser? get currentUser => switch (_firebaseAuth.currentUser) {
        final User user => user.toAuthUser(),
        null => null,
      };

  /// Internal helper to sign in with a given [AuthCredential].
  Future<UserCredential> _signInWithCredential(
    AuthCredential credential,
  ) async {
    try {
      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      const accountExists = 'account-exists-with-different-credential';

      if (e.code == accountExists && e.email != null && e.credential != null) {
        throw AccountExistsWithDifferentCredentialException(
          message: e.message ??
              'The account for ${e.email} '
                  'already exists with a different sign-in method.',
          email: e.email!,
        );
      }
      throw FirebaseSignInException(
        code: e.code,
        message:
            e.message ?? 'Unknown Firebase error during credential sign-in.',
      );
    }
  }
}

extension on User {
  AuthUser toAuthUser() => (
        id: uid,
        email: email,
        displayName: displayName,
        photoUrl: photoURL,
        isAnonymous: isAnonymous,
      );
}
