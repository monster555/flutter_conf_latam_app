import 'dart:io';

import 'package:conf_cache/conf_cache.dart';
import 'package:conf_cache/src/provider/conf_box_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/hive_test_helper.dart';
import '../mocks/generated_mocks.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    HiveTestHelper.setUp();
  });

  setUp(ConfBoxProvider.clearTestBoxes);

  tearDownAll(HiveTestHelper.tearDown);

  group('ConfCacheSystem', () {
    test('initialize uses correct dependencies', () async {
      var directoryRequested = false;
      var hiveInitialized = false;
      var passedPath = '';

      await ConfCacheSystem.initialize(
        directoryProvider: () {
          directoryRequested = true;
          return Future.value(Directory('fake/path'));
        },
        hiveInitializer: (path) {
          hiveInitialized = true;
          passedPath = path;
        },
      );

      expect(directoryRequested, isTrue);
      expect(hiveInitialized, isTrue);
      expect(passedPath, equals('fake/path'));
    });

    test('cache factory correctly uses registered boxes', () async {
      final speakersMock = MockBox<String>();
      ConfBoxProvider.registerTestBox('speakers_cache', speakersMock);

      final speakersCache = await ConfCacheFactory.speakers();

      expect(speakersCache, isA<ConfHybridCache>());
      expect(speakersCache.boxName, equals('speakers_cache'));
    });

    test('all required caches are properly set up', () async {
      final speakersMock = MockBox<String>();
      final sponsorsMock = MockBox<String>();
      final agendaMock = MockBox<String>();

      ConfBoxProvider.registerTestBox('speakers_cache', speakersMock);
      ConfBoxProvider.registerTestBox('sponsors_cache', sponsorsMock);
      ConfBoxProvider.registerTestBox('agenda_cache', agendaMock);

      final speakersCache = await ConfCacheFactory.speakers();
      final sponsorsCache = await ConfCacheFactory.sponsors();
      final agendaCache = await ConfCacheFactory.agenda();

      expect(speakersCache, isNotNull);
      expect(sponsorsCache, isNotNull);
      expect(agendaCache, isNotNull);

      expect(speakersCache.boxName, equals('speakers_cache'));
      expect(sponsorsCache.boxName, equals('sponsors_cache'));
      expect(agendaCache.boxName, equals('agenda_cache'));
    });
  });
}
