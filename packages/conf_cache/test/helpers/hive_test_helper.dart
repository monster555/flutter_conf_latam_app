import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;

/// Manages Hive initialization and cleanup for tests.
///
/// Creates isolated temporary directories for Hive storage to prevent
/// test interference and ensures proper cleanup after tests complete.
class HiveTestHelper {
  static late Directory _tempDir;

  /// Initialize Hive for testing with a temporary directory
  static void setUp() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    _tempDir = Directory(path.join('.dart_tool', 'test', 'hive_$timestamp'));
    if (!_tempDir.existsSync()) {
      _tempDir.createSync(recursive: true);
    }

    Hive.init(_tempDir.path);
  }

  /// Clean up Hive test directory
  static void tearDown() {
    if (_tempDir.existsSync()) {
      _tempDir.deleteSync(recursive: true);
    }
  }
}
