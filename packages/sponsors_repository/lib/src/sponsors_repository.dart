import 'package:conf_cache/conf_cache.dart';
import 'package:conf_data_source/conf_data_source.dart';
import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:sponsors_repository/src/sponsors_repository_exception.dart';

class SponsorsRepository {
  SponsorsRepository({
    required ConfDataSource dataSource,
    required ConfCache cache,
  }) : _cache = cache,
       _dataSource = dataSource;

  final ConfDataSource _dataSource;
  final ConfCache _cache;

  static const collectionPath = 'sponsors';

  Future<List<Sponsor>> getSponsors({bool forceRefresh = false}) async {
    return withCache<List<Sponsor>>(
      key: 'sponsors',
      cacheService: _cache,
      fromDataSource: _fetchSponsors,
      fromJson: (json) {
        final items = json['items'] as List;
        return items
            .cast<Map<String, dynamic>>()
            .map(Sponsor.fromJson)
            .toList();
      },
      toJson: (sponsors) => {'items': sponsors.map((s) => s.toJson()).toList()},
      forceRefresh: forceRefresh,
    );
  }

  Future<List<Sponsor>> _fetchSponsors() async {
    try {
      final data = await _dataSource.getSponsors();

      return data.map(Sponsor.fromJson).toList();
    } on ConfDataSourceException catch (e) {
      throw SponsorsRepositoryException(
        'Failed to fetch speakers from Firestore',
        cause: e,
      );
    } on Exception catch (e) {
      throw SponsorsRepositoryException(
        'Unknown error when fetching speakers',
        cause: e,
      );
    }
  }
}
