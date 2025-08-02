import 'dart:convert';
import 'dart:developer';

import 'package:clock/clock.dart';
import 'package:conf_cache/src/core/conf_cache_base.dart';
import 'package:hive/hive.dart';

class ConfHybridCache implements ConfCache {
  ConfHybridCache({required this.boxName, required Box<String> box})
    : _box = box;

  final String boxName;
  late final Box<String> _box;

  // Simple memory cache with expiration
  // key -> (value, expirationTime)
  final Map<String, ({String value, DateTime expiry})> memoryCache = {};

  @override
  Future<String?> getString(String key) async {
    final now = clock.now();
    // Check memory first
    if (memoryCache.containsKey(key)) {
      final entry = memoryCache[key]!;
      if (now.isBefore(entry.expiry)) {
        return entry.value;
      }
      // Remove expired entry
      memoryCache.remove(key);
    }

    // Then check persistent storage
    final rawData = _box.get(key);
    if (rawData != null) {
      try {
        final data = jsonDecode(rawData) as Map<String, dynamic>;
        final value = data['value'] as String;
        final expiry = DateTime.parse(data['expiry'] as String);

        if (now.isBefore(expiry)) {
          // Cache in memory for future quick access
          memoryCache[key] = (value: value, expiry: expiry);
          return value;
        } else {
          // Clean up expired entry
          await _box.delete(key);
        }
      } on Exception catch (e) {
        log(
          'Failed to parse cache entry: $e',
          error: e,
          name: 'ConfHybridCache',
        );
        // Invalid format, remove corrupted data
        await _box.delete(key);
      }
    }

    return null;
  }

  @override
  Future<void> putString(String key, String value, {Duration? maxAge}) async {
    final expiry = clock.now().add(maxAge ?? const Duration(days: 2));

    memoryCache[key] = (value: value, expiry: expiry);

    final data = {'value': value, 'expiry': expiry.toIso8601String()};

    await _box.put(key, jsonEncode(data));
  }

  @override
  Future<void> delete(String key) async {
    memoryCache.remove(key);
    await _box.delete(key);
  }

  @override
  Future<void> clear() async {
    memoryCache.clear();
    await _box.clear();
  }
}
