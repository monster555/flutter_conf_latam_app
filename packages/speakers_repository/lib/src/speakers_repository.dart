import 'dart:developer';

import 'package:conf_firestore_data_source/conf_firestore_data_source.dart';
import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:speakers_repository/src/speakers_repository_exception.dart';

class SpeakersRepository {
  SpeakersRepository({required this.dataSource});

  final ConfFirestoreDataSource dataSource;

  static const collectionPath = 'speakers';

  Future<List<Speaker>> getSpeakers() async {
    try {
      final data = await dataSource.getCollection(collectionPath);

      log('Fetched ${data.length} speakers from Firestore');

      return data.map(Speaker.fromJson).toList();
    } on ConfFirestoreDataSourceException catch (e) {
      throw SpeakersRepositoryException(
        'Failed to fetch speakers from Firestore',
        cause: e,
      );
    } on Exception catch (e) {
      throw SpeakersRepositoryException(
        'Unknown error when fetching speakers',
        cause: e,
      );
    }
  }

  Future<Speaker> getSpeaker(String id) async {
    try {
      final data = await dataSource.getDocument(collectionPath, id);
      if (data == null) {
        throw SpeakersRepositoryException('Speaker not found');
      }
      return Speaker.fromJson(data);
    } on ConfFirestoreDataSourceException catch (e) {
      throw SpeakersRepositoryException(
        'Failed to fetch speaker from Firestore',
        cause: e,
      );
    } on Exception catch (e) {
      throw SpeakersRepositoryException(
        'Unknown error when fetching speaker',
        cause: e,
      );
    }
  }
}
