import 'package:agenda_repository/src/agenda_repository_exception.dart';
import 'package:conf_cache/conf_cache.dart';
import 'package:conf_core/conf_core.dart';
import 'package:conf_data_source/conf_data_source.dart';
import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:flutter/foundation.dart';

/// Repository responsible for fetching and manipulating session data.
///
/// Provides a clean API for accessing session information while abstracting
/// the underlying data source implementation. This repository handles data
/// normalization to ensure consistent types across different data sources.
class AgendaRepository {
  /// Creates a sessions repository with the specified data source and cache.
  ///
  /// The [dataSource] parameter provides the underlying data access
  /// implementation.
  /// The [cache] parameter provides the caching mechanism to improve
  /// performance.
  AgendaRepository({
    required ConfDataSource dataSource,
    required ConfCache cache,
  }) : _dataSource = dataSource,
       _cache = cache;

  final ConfDataSource _dataSource;
  final ConfCache _cache;

  /// Fetches the complete conference schedule, using cache when available.
  ///
  /// Returns a list of [ScheduleDay] objects representing the conference
  /// schedule.
  /// Each day contains time slots with their respective sessions.
  Future<List<ScheduleDay>> getAgenda({
    required String languageCode,
    bool forceRefresh = false,
  }) async {
    return withCache<List<ScheduleDay>>(
      key: 'agenda_$languageCode',
      cacheService: _cache,
      fromDataSource: () => _fetchAgenda(languageCode),
      fromJson: (json) {
        final items = json['items'] as List;
        return items
            .cast<Map<String, dynamic>>()
            .map(ScheduleDay.fromJson)
            .toList();
      },
      toJson: (schedule) => {'items': schedule.map((s) => s.toJson()).toList()},
      forceRefresh: forceRefresh,
    );
  }

  Future<List<ScheduleDay>> _fetchAgenda(String languageCode) async {
    try {
      final data = await _dataSource.getSessions(languageCode: languageCode);

      // Normalize and convert to ScheduleDay objects
      return data.map((dayData) {
        final normalizedData = _normalizeScheduleData(dayData);
        return ScheduleDay.fromJson(normalizedData);
      }).toList();
    } on ConfDataSourceException catch (e) {
      throw AgendaRepositoryException(
        'Failed to fetch agenda from data source',
        cause: e,
      );
    } on Exception catch (e) {
      throw AgendaRepositoryException(
        'Unknown error when fetching agenda',
        cause: e,
      );
    }
  }

  @visibleForTesting
  Map<String, dynamic> normalizeScheduleData(Map<String, dynamic> data) =>
      _normalizeScheduleData(data);

  /// Normalizes schedule data to ensure type compatibility.
  Map<String, dynamic> _normalizeScheduleData(Map<String, dynamic> data) {
    final normalized = Map<String, dynamic>.from(data);

    // Normalize slots array
    if (normalized['slots'] != null) {
      final normalizedSlots = <Map<String, dynamic>>[];

      for (final slot in normalized['slots'] as List) {
        final normalizedSlot = Map<String, dynamic>.from(slot as Map);

        // Normalize sessions within each slot
        if (normalizedSlot['sessions'] != null) {
          final normalizedSessions = <Map<String, dynamic>>[];

          for (final session in normalizedSlot['sessions'] as List) {
            final normalizedSession = _normalizeSessionData(
              Map<String, dynamic>.from(session as Map),
            );
            normalizedSessions.add(normalizedSession);
          }

          normalizedSlot['sessions'] = normalizedSessions;
        }

        normalizedSlots.add(normalizedSlot);
      }

      normalized['slots'] = normalizedSlots;
    }

    return normalized;
  }

  /// Public access to data normalization for testing purposes.
  @visibleForTesting
  Map<String, dynamic> normalizeSessionData(Map<String, dynamic> data) =>
      _normalizeSessionData(data);

  /// Normalizes session data to ensure type compatibility.
  Map<String, dynamic> _normalizeSessionData(Map<String, dynamic> data) {
    final normalized = Map<String, dynamic>.from(data);

    // Normalize session-specific fields
    if (normalized['speakers'] != null) {
      normalized['speakers'] = DataNormalizer.normalizeMapList(
        normalized['speakers'],
      );
    }

    if (normalized['tags'] != null) {
      normalized['tags'] = DataNormalizer.normalizeStringList(
        normalized['tags'],
      );
    }

    if (normalized['requirements'] != null) {
      normalized['requirements'] = DataNormalizer.normalizeStringList(
        normalized['requirements'],
      );
    }

    if (normalized['startDate'] != null) {
      final utcDate = DateTime.parse(normalized['startDate'] as String);
      normalized['startDate'] = utcDate.toLocal().toIso8601String();
    }

    if (normalized['endDate'] != null) {
      final utcDate = DateTime.parse(normalized['endDate'] as String);
      normalized['endDate'] = utcDate.toLocal().toIso8601String();
    }

    return normalized;
  }
}
