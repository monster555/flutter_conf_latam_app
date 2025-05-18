import 'package:conf_auth_data_source/conf_auth_data_source.dart';
import 'package:conf_auth_repository/conf_auth_repository.dart';
import 'package:conf_firestore_data_source/conf_firestore_data_source.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_conf_latam/firebase_options.dart';
import 'package:speakers_repository/speakers_repository.dart';
import 'package:sponsors_repository/sponsors_repository.dart';

typedef AppDependencies =
    ({
      SpeakersRepository speakersRepository,
      SponsorsRepository sponsorsRepository,
      IConfAuthRepository confAuthRepository,
    });

Future<AppDependencies> initializeApp() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final dataSource = ConfFirestoreDataSource();
  final authDataSource = ConfAuthDataSource();

  final speakersRepository = SpeakersRepository(dataSource: dataSource);
  final sponsorsRepository = SponsorsRepository(dataSource: dataSource);
  final confAuthRepository = ConfAuthRepository(authDataSource: authDataSource);

  return (
    speakersRepository: speakersRepository,
    sponsorsRepository: sponsorsRepository,
    confAuthRepository: confAuthRepository,
  );
}
