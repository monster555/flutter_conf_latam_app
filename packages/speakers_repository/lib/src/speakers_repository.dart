import 'package:conf_cache/conf_cache.dart';
import 'package:conf_core/conf_core.dart';
import 'package:conf_data_source/conf_data_source.dart';
import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:flutter/foundation.dart';
import 'package:speakers_repository/src/speakers_repository_exception.dart';

/// Repository responsible for fetching and manipulating speaker data.
///
/// Provides a clean API for accessing speaker information while abstracting
/// the underlying data source implementation. This repository handles data
/// normalization to ensure consistent types across different data sources.
class SpeakersRepository {
  /// Creates a speaker repository with the specified data source and cache.
  ///
  /// The [dataSource] parameter provides the underlying data access
  /// implementation.
  /// The [cache] parameter provides the caching mechanism to improve
  /// performance.
  SpeakersRepository({
    required ConfDataSource dataSource,
    required ConfCache cache,
  }) : _dataSource = dataSource,
       _cache = cache;

  final ConfDataSource _dataSource;
  final ConfCache _cache;

  /// Fetches a list of speakers, using cache when available.
  ///
  /// Returns a list of [SpeakerSummary] objects representing the speakers.
  /// First attempts to retrieve from cache, falling back to data source only
  /// when needed.
  ///
  /// The [languageCode] parameter specifies the language for localized content.
  /// The [forceRefresh] parameter can be set to true to bypass the cache and
  /// fetch fresh data.
  Future<List<SpeakerSummary>> getSpeakers({
    required String languageCode,
    bool forceRefresh = false,
  }) async {
    return withCache<List<SpeakerSummary>>(
      key: 'speakers_$languageCode',
      cacheService: _cache,
      fromDataSource: () => _fetchSpeakers(languageCode),
      fromJson: (json) {
        final items = json['items'] as List;
        return items
            .cast<Map<String, dynamic>>()
            .map(SpeakerSummary.fromJson)
            .toList();
      },
      toJson: (speakers) => {'items': speakers.map((s) => s.toJson()).toList()},
      forceRefresh: forceRefresh,
    );
  }

  Future<List<SpeakerSummary>> _fetchSpeakers(String languageCode) async {
    try {
      final data = await _dataSource.getSpeakers(languageCode: languageCode);

      return data.map(SpeakerSummary.fromJson).toList();
    } on ConfDataSourceException catch (e) {
      throw SpeakersRepositoryException(
        'Failed to fetch speakers from data source',
        cause: e,
      );
    } on Exception catch (e) {
      throw SpeakersRepositoryException(
        'Unknown error when fetching speakers',
        cause: e,
      );
    }
  }

  /// Fetches a speaker by their unique identifier, using cache when available.
  ///
  /// Returns a [Speaker] object representing the speaker.
  /// First attempts to retrieve from cache, falling back to data source only
  /// when needed.
  ///
  /// Throws a [SpeakersRepositoryException] if the speaker is not found
  /// or if an error occurs while fetching the data.
  Future<Speaker> getSpeakerById(
    String id, {
    required String languageCode,
    bool forceRefresh = false,
  }) async {
    return withCache<Speaker>(
      key: 'speaker_${id}_$languageCode',
      cacheService: _cache,
      fromDataSource: () => _fetchSpeakerById(id, languageCode),
      fromJson:
          (json) => Speaker.fromJson(json['speaker'] as Map<String, dynamic>),
      toJson: (speaker) => {'speaker': speaker.toJson()},
      forceRefresh: forceRefresh,
    );
  }

  Future<Speaker> _fetchSpeakerById(String id, String languageCode) async {
    try {
      final data = await _dataSource.getSpeakerById(
        id,
        languageCode: languageCode,
      );

      if (data == null) {
        throw SpeakersRepositoryException('Speaker not found');
      }

      // Normalize data to ensure type compatibility
      final normalizedData = _normalizeSpeakerData(data);

      return Speaker.fromJson(normalizedData);
    } on ConfDataSourceException catch (e) {
      throw SpeakersRepositoryException(
        'Failed to fetch speaker from data source',
        cause: e,
      );
    } on Exception catch (e) {
      throw SpeakersRepositoryException(
        'Unknown error when fetching speaker',
        cause: e,
      );
    }
  }

  /// Public access to data normalization for testing purposes.
  @visibleForTesting
  Map<String, dynamic> normalizeSpeakerData(Map<String, dynamic> data) =>
      _normalizeSpeakerData(data);

  /// Normalizes speaker data to ensure type compatibility.
  ///
  /// This method handles mismatches between the dynamic typing of data sources
  /// (particularly JavaScript-based ones) and Dart's static type system.
  ///
  /// Uses the shared [DataNormalizer]  utility for consistent type conversions.
  Map<String, dynamic> _normalizeSpeakerData(Map<String, dynamic> data) {
    final normalized = Map<String, dynamic>.from(data);

    normalized['social_media_links'] = DataNormalizer.normalizeMapList(
      normalized['social_media_links'],
    );
    normalized['languages'] = DataNormalizer.normalizeStringList(
      normalized['languages'],
    );

    return normalized;
  }
}
