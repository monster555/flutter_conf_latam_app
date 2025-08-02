import 'package:conf_cache/src/core/conf_hybrid_cache.dart';
import 'package:conf_cache/src/provider/conf_box_provider.dart';

/// Factory for creating domain-specific cache instances.
///
/// This factory provides pre-configured cache instances for different
/// parts of the application, ensuring consistent naming and configuration.
class ConfCacheFactory {
  /// Creates a cache for the speaker-related data.
  static Future<ConfHybridCache> speakers() async {
    final box = await ConfBoxProvider.getBox('speakers_cache');
    return ConfHybridCache(boxName: 'speakers_cache', box: box);
  }

  /// Creates a cache for sponsor-related data.
  static Future<ConfHybridCache> sponsors() async {
    final box = await ConfBoxProvider.getBox('sponsors_cache');
    return ConfHybridCache(boxName: 'sponsors_cache', box: box);
  }

  /// Creates a cache for conference agenda data.
  static Future<ConfHybridCache> agenda() async {
    final box = await ConfBoxProvider.getBox('agenda_cache');
    return ConfHybridCache(boxName: 'agenda_cache', box: box);
  }
}
