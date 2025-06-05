import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

/// Provides initialized Hive boxes.
///
/// This centralizes box initialization and management.
class ConfBoxProvider {
  static final Map<String, Box<String>> _boxes = {};
  static final Map<String, Box<String>> _testBoxes = {};

  /// Initializes and returns a box with the given name.
  ///
  /// If a box with this name has already been initialized, returns the existing
  /// instance.
  /// If a test box with this name has been registered, returns that instead.
  static Future<Box<String>> getBox(String name) async {
    // Check for test box first
    if (_testBoxes.containsKey(name)) {
      return _testBoxes[name]!;
    }

    // Check for existing box
    if (_boxes.containsKey(name)) {
      return _boxes[name]!;
    }

    // Initialize new box
    final box = await Hive.openBox<String>(name);
    _boxes[name] = box;
    return box;
  }

  /// Registers a mock box for testing.
  static void registerTestBox(String name, Box<String> mockBox) {
    _testBoxes[name] = mockBox;
  }

  /// Clears all test boxes.
  static void clearTestBoxes() {
    _testBoxes.clear();
  }

  /// Closes all boxes.
  static Future<void> closeAll() async {
    for (final box in _boxes.values) {
      await box.close();
    }
    _boxes.clear();
  }

  /// For testing only - checks if a box is currently cached
  @visibleForTesting
  static bool hasBox(String name) {
    return _boxes.containsKey(name);
  }
}
