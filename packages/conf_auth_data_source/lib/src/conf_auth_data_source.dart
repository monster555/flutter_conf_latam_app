import 'dart:io';

import 'package:conf_auth_data_source/conf_auth_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final credential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      final result = await _signInWithCredential(credential);
      return result.user!.toAuthUser();
    } on SocketException {
      throw const NoInternetException();
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
      return result.user!.toAuthUser();
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
    } on Exception catch (_) {
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
