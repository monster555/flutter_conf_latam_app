import 'dart:io';

import 'package:conf_cache/conf_cache.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

typedef DirectoryProvider = Future<Directory> Function();
typedef HiveInitializer = void Function(String path);
typedef CacheInstances =
    ({ConfCache speakers, ConfCache sponsors, ConfCache agenda});

// coverage:ignore-start
void initializeHive(String path) => Hive.init(path);
// coverage:ignore-end

class ConfCacheSystem {
  // coverage:ignore-start
  ConfCacheSystem._();
  // coverage:ignore-end

  static bool _isInitialized = false;

  /// Initializes the caching system and returns initialized cache instances.
  ///
  /// This maintains encapsulation while still allowing the main app to
  /// inject specific caches into repositories.
  static Future<CacheInstances> initialize({
    DirectoryProvider? directoryProvider,
    HiveInitializer? hiveInitializer,
  }) async {
    if (!_isInitialized) {
      final provider = directoryProvider ?? getApplicationDocumentsDirectory;
      final initializer = hiveInitializer ?? initializeHive;

      final appDir = await provider();
      initializer(appDir.path);
      _isInitialized = true;
    }

    final (speakersCache, sponsorsCache, agendaCache) = (
      await ConfCacheFactory.speakers(),
      await ConfCacheFactory.sponsors(),
      await ConfCacheFactory.agenda(),
    );

    return (
      speakers: speakersCache,
      sponsors: sponsorsCache,
      agenda: agendaCache,
    );
  }
}
