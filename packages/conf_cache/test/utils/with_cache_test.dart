import 'dart:convert';

import 'package:conf_cache/src/utils/with_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_model.dart';
import '../mocks/generated_mocks.dart';

void main() {
  late MockConfCache mockCache;
  late TestModel testData;
  late bool dataSourceCalled;

  setUp(() {
    mockCache = MockConfCache();
    testData = const TestModel(name: 'test', count: 42);
    dataSourceCalled = false;

    // Default behavior for mock
    when(mockCache.getString(any)).thenAnswer((_) async => null);
    when(
      mockCache.putString(any, any, maxAge: anyNamed('maxAge')),
    ).thenAnswer((_) async => {});
    when(mockCache.delete(any)).thenAnswer((_) async => {});
  });

  tearDown(() {
    reset(mockCache);
  });

  // Helper function simulating a data source
  Future<TestModel> fetchFromDataSource() async {
    dataSourceCalled = true;
    return testData;
  }

  group('withCache', () {
    test('returns cached data when available and valid', () async {
      final cachedJson = jsonEncode(testData.toJson());
      when(mockCache.getString('test_key')).thenAnswer((_) async => cachedJson);

      final result = await withCache<TestModel>(
        key: 'test_key',
        cacheService: mockCache,
        fromDataSource: fetchFromDataSource,
        fromJson: TestModel.fromJson,
        toJson: (data) => data.toJson(),
      );

      expect(result, equals(testData));
      expect(dataSourceCalled, isFalse);
      verifyNever(mockCache.putString(any, any, maxAge: anyNamed('maxAge')));
    });

    test('fetches from data source when cache is empty', () async {
      final result = await withCache<TestModel>(
        key: 'test_key',
        cacheService: mockCache,
        fromDataSource: fetchFromDataSource,
        fromJson: TestModel.fromJson,
        toJson: (data) => data.toJson(),
      );

      expect(result, equals(testData));
      expect(dataSourceCalled, isTrue);
      verify(
        mockCache.putString('test_key', jsonEncode(testData.toJson())),
      ).called(1);
    });

    test('bypasses cache when forceRefresh is true', () async {
      final cachedJson = jsonEncode(
        const TestModel(name: 'cached', count: 100).toJson(),
      );
      when(mockCache.getString('test_key')).thenAnswer((_) async => cachedJson);

      final result = await withCache<TestModel>(
        key: 'test_key',
        cacheService: mockCache,
        fromDataSource: fetchFromDataSource,
        fromJson: TestModel.fromJson,
        toJson: (data) => data.toJson(),
        forceRefresh: true,
      );

      expect(result, equals(testData));
      expect(dataSourceCalled, isTrue);
      verifyNever(mockCache.getString(any));
      verify(
        mockCache.putString('test_key', jsonEncode(testData.toJson())),
      ).called(1);
    });

    test('handles and cleans up corrupted cache entries', () async {
      when(
        mockCache.getString('test_key'),
      ).thenAnswer((_) async => '{"invalid": json');

      final result = await withCache<TestModel>(
        key: 'test_key',
        cacheService: mockCache,
        fromDataSource: fetchFromDataSource,
        fromJson: TestModel.fromJson,
        toJson: (data) => data.toJson(),
      );

      expect(result, equals(testData));
      expect(dataSourceCalled, isTrue);
      verify(mockCache.delete('test_key')).called(1);
      verify(
        mockCache.putString('test_key', jsonEncode(testData.toJson())),
      ).called(1);
    });

    test('respects maxAge parameter when caching', () async {
      const customMaxAge = Duration(hours: 2);

      await withCache<TestModel>(
        key: 'test_key',
        cacheService: mockCache,
        fromDataSource: fetchFromDataSource,
        fromJson: TestModel.fromJson,
        toJson: (data) => data.toJson(),
        maxAge: customMaxAge,
      );

      verify(
        mockCache.putString(
          'test_key',
          jsonEncode(testData.toJson()),
          maxAge: customMaxAge,
        ),
      ).called(1);
    });
  });
}
