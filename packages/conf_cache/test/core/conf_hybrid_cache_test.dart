import 'package:clock/clock.dart';
import 'package:conf_cache/conf_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/cache_test_helpers.dart';
import '../mocks/generated_mocks.dart';

void main() {
  late MockBox<String> mockBox;
  late ConfHybridCache cache;

  setUp(() {
    mockBox = createMockBox();
    cache = ConfHybridCache(boxName: 'test_box', box: mockBox);
  });

  tearDown(() {
    cache.memoryCache.clear();
    reset(mockBox);
  });

  group('initialization', () {
    test('can be instantiated with required parameters', () {
      expect(cache, isNotNull);
      expect(cache.boxName, equals('test_box'));
    });
  });

  group('getString', () {
    test('returns null if the key is not found', () async {
      when(mockBox.get('missing_key')).thenReturn(null);
      final value = await cache.getString('missing_key');
      expect(value, isNull);
      verify(mockBox.get('missing_key')).called(1);
    });

    test('returns value from memory cache when not expired', () {
      addToMemoryCache(cache, testKey, 'memory_value');

      expect(cache.getString(testKey), completion(equals('memory_value')));
      verifyNever(mockBox.get(any));
    });

    test('returns value from Hive when not in memory cache', () async {
      setupBoxResponse(mockBox, testKey, 'box_value');

      final result = await cache.getString(testKey);

      expect(result, equals('box_value'));
      expect(cache.memoryCache[testKey]?.value, equals('box_value'));
    });

    test('removes expired value from memory cache', () async {
      addToMemoryCache(
        cache,
        'expired_key',
        'expired_value',
        expiry: fiveMinutesAgo,
      );
      when(mockBox.get('expired_key')).thenReturn(null);

      final result = await cache.getString('expired_key');

      expect(result, isNull);
      expect(cache.memoryCache.containsKey('expired_key'), isFalse);
    });

    test('returns null when Hive entry is expired', () async {
      setupBoxResponse(
        mockBox,
        testKey,
        'expired_box_value',
        expiry: fiveMinutesAgo,
      );

      final result = await cache.getString(testKey);

      expect(result, isNull);
      verify(mockBox.delete(testKey)).called(1);
    });

    test('handles corrupted data in Hive', () async {
      when(mockBox.get(testKey)).thenReturn('not valid json');

      final result = await cache.getString(testKey);

      expect(result, isNull);
      verify(mockBox.delete(testKey)).called(1);
    });

    group('edge cases', () {
      test('cleans up expired entries in Hive during retrieval', () async {
        setupBoxResponse(
          mockBox,
          'expired_entry',
          'old_value',
          expiry: fiveMinutesAgo,
        );

        await cache.getString('expired_entry');

        verify(mockBox.delete('expired_entry')).called(1);
      });

      test('handles completely malformed data in Hive', () async {
        when(mockBox.get('malformed')).thenReturn('<<<not json at all>>>');

        final result = await cache.getString('malformed');

        expect(result, isNull);
        verify(mockBox.delete('malformed')).called(1);
      });

      test('handles empty string data in Hive', () async {
        when(mockBox.get('empty')).thenReturn('');

        final result = await cache.getString('empty');

        expect(result, isNull);
        verify(mockBox.delete('empty')).called(1);
      });
    });
  });

  group('putString', () {
    test('stores value in memory cache and Hive', () async {
      await cache.putString(testKey, testValue);

      expect(cache.memoryCache.containsKey(testKey), isTrue);
      expect(cache.memoryCache[testKey]!.value, equals(testValue));

      verify(mockBox.put(testKey, any)).called(1);
    });

    test('uses provided maxAge when specified', () async {
      await cache.putString(testKey, testValue, maxAge: fifteenMinutes);

      final expectedExpiry = clock.now().add(fifteenMinutes);
      final actualExpiry = cache.memoryCache[testKey]!.expiry;

      expect(
        actualExpiry.difference(expectedExpiry).inSeconds.abs() < 1,
        isTrue,
        reason: 'Expiry should be set based on maxAge parameter',
      );

      verify(mockBox.put(testKey, any)).called(1);
    });
  });

  group('delete', () {
    test('removes entry from memory cache and Hive', () async {
      addToMemoryCache(cache, testKey, testValue);

      await cache.delete(testKey);

      expect(cache.memoryCache.containsKey(testKey), isFalse);
      verify(mockBox.delete(testKey)).called(1);
    });
  });

  group('clear', () {
    test('clears all entries from memory cache and Hive', () async {
      addToMemoryCache(cache, 'key1', 'value1');
      addToMemoryCache(cache, 'key2', 'value2');

      await cache.clear();

      expect(cache.memoryCache.isEmpty, isTrue);
      verify(mockBox.clear()).called(1);
    });
  });

  group('time-controlled tests', () {
    test('correctly handles time-dependent cache operations', () async {
      final fixedTime = DateTime(2023, 1, 1, 12);

      await withClock(Clock.fixed(fixedTime), () async {
        setupBoxResponse(
          mockBox,
          'time_test',
          'time_value',
          expiry: const Duration(hours: 1),
        );

        final result1 = await cache.getString('time_test');
        expect(result1, equals('time_value'));

        await withClock(
          Clock.fixed(fixedTime.add(const Duration(hours: 2))),
          () async {
            final result2 = await cache.getString('time_test');
            expect(result2, isNull);
            verify(mockBox.delete('time_test')).called(1);
          },
        );
      });
    });
  });
}
