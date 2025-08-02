// ignore_for_file: type=lint
// coverage:ignore-file

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

/// Firebase configuration template for CI/CD builds only.
///
/// This provides placeholder values that enable static analysis
/// and dependency resolution without exposing real Firebase credentials.
///
/// **WARNING: This file contains placeholder values only.**
/// **Do not use in production builds.**
///
/// ## Usage
///
/// In CI pipeline:
/// ```bash
/// cp lib/firebase_options_template.dart lib/firebase_options.dart
/// ```
///
/// For production, replace with real configuration:
/// ```bash
/// flutterfire configure
/// ```
class DefaultFirebaseOptions {
  /// Private constructor prevents instantiation.
  const DefaultFirebaseOptions._();

  /// Returns Firebase options with placeholder values for CI analysis.
  ///
  /// These values allow the app to compile and analyze without
  /// requiring real Firebase credentials in the CI environment.
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "CI_TEMPLATE_API_KEY",
      authDomain: "CI_TEMPLATE_AUTH_DOMAIN",
      projectId: "CI_TEMPLATE_PROJECT_ID",
      storageBucket: "CI_TEMPLATE_STORAGE_BUCKET",
      messagingSenderId: "CI_TEMPLATE_MESSAGING_SENDER_ID",
      appId: "CI_TEMPLATE_APP_ID",
    );
  }
}
