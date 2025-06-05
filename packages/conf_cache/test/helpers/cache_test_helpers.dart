import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:conf_cache/conf_cache.dart';
import 'package:conf_cache/src/provider/conf_box_provider.dart';
import 'package:mockito/mockito.dart';

import '../mocks/generated_mocks.dart';

const testKey = 'test_key';
const testValue = 'test_value';
const oneHour = Duration(hours: 1);
const fifteenMinutes = Duration(minutes: 15);
const fiveMinutesAgo = Duration(minutes: -5);

MockBox<String> createMockBox() {
  final mockBox = MockBox<String>();

  when(mockBox.put(any, any)).thenAnswer((_) async {});
  when(mockBox.delete(any)).thenAnswer((_) async {});
  when(mockBox.clear()).thenAnswer((_) async => 0);

  return mockBox;
}

void setupAllMockBoxes() {
  final speakersMock = MockBox<String>();
  final sponsorsMock = MockBox<String>();
  final agendaMock = MockBox<String>();

  when(speakersMock.put(any, any)).thenAnswer((_) async {});
  when(speakersMock.get(any)).thenAnswer((invocation) {
    final key = invocation.positionalArguments[0];
    final expiry = clock.now().add(const Duration(hours: 1)).toIso8601String();
    if (key == 'test_key') {
      return '{"value":"test_value","expiry":"$expiry"}';
    }
    return null;
  });

  ConfBoxProvider.registerTestBox('speakers_cache', speakersMock);
  ConfBoxProvider.registerTestBox('sponsors_cache', sponsorsMock);
  ConfBoxProvider.registerTestBox('agenda_cache', agendaMock);
}

ConfHybridCache createTestCache() {
  return ConfHybridCache(boxName: 'test_box', box: createMockBox());
}

void addToMemoryCache(
  ConfHybridCache cache,
  String key,
  String value, {
  Duration? expiry,
}) {
  cache.memoryCache[key] = (
    value: value,
    expiry: clock.now().add(expiry ?? oneHour),
  );
}

void setupBoxResponse(
  MockBox<String> mockBox,
  String key,
  String value, {
  Duration? expiry,
}) {
  when(mockBox.get(key)).thenReturn(
    jsonEncode({
      'value': value,
      'expiry': clock.now().add(expiry ?? oneHour).toIso8601String(),
    }),
  );
}
