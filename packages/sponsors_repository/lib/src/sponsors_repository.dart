import 'package:conf_data_source/conf_data_source.dart';
import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:sponsors_repository/src/sponsors_repository_exception.dart';

class SponsorsRepository {
  SponsorsRepository({required this.dataSource});
  final ConfDataSource dataSource;

  static const collectionPath = 'sponsors';

  Future<List<Sponsor>> getSponsors() async {
    try {
      final data = await dataSource.getSponsors();

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
