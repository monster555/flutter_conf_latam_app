import 'dart:convert';
import 'dart:developer';

import 'package:conf_cache/conf_cache.dart';
import 'package:conf_cache/src/core/conf_cache_base.dart';

/// A utility function that handles caching logic.
///
/// Attempts to get data from cache first. If not available or expired,
/// fetches from the data source and caches the result.
Future<T> withCache<T>({
  required String key,
  required ConfCache cacheService,
  required Future<T> Function() fromDataSource,
  required T Function(Map<String, dynamic> json) fromJson,
  required Map<String, dynamic> Function(T data) toJson,
  Duration? maxAge,
  bool forceRefresh = false,
}) async {
  if (forceRefresh) {
    // Skip cache check completely
    final data = await fromDataSource();
    await cacheService.putString(key, jsonEncode(toJson(data)), maxAge: maxAge);
    return data;
  }

  // Check cache first
  final jsonString = await cacheService.getString(key);
  if (jsonString != null) {
    try {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return fromJson(jsonMap);
    } on Exception catch (error, stackTrace) {
      log(
        'Failed to parse cache entry for key "$key": $error',
        name: 'withCache',
        error: error,
        stackTrace: stackTrace,
      );
      await cacheService.delete(key);
    }
  }

  // Fetch from data source
  final data = await fromDataSource();

  // Cache the result
  final jsonMap = toJson(data);
  await cacheService.putString(key, jsonEncode(jsonMap), maxAge: maxAge);

  return data;
}
