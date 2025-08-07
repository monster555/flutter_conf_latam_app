import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:conf_cloud_functions_data_source/src/conf_cloud_functions_exception.dart';
import 'package:conf_data_source/conf_data_source.dart';

class ConfCloudFunctionsDataSource implements ConfDataSource {
  ConfCloudFunctionsDataSource({FirebaseFunctions? functionsInstance})
    : functions = functionsInstance ?? FirebaseFunctions.instance;

  final FirebaseFunctions functions;

  @override
  Future<List<Map<String, dynamic>>> getSpeakers({String? languageCode}) async {
    try {
      final result = await functions
          .httpsCallable('getSpeakers')
          .call<List<Object?>>({'lang': languageCode ?? 'es'});

      return (result.data as List)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    } catch (e) {
      log('Error fetching speakers: $e', name: 'ConfCloudFunctionsDataSource');
      throw ConfCloudFunctionsException('Failed to fetch speakers: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getSpeakerById(
    String id, {
    String? languageCode,
  }) async {
    try {
      final result = await functions
          .httpsCallable('getSpeakerById')
          .call<Object?>({'speakerId': id, 'lang': languageCode ?? 'es'});

      return result.data != null
          ? Map<String, dynamic>.from(result.data! as Map)
          : null;
    } catch (e) {
      throw ConfCloudFunctionsException('Failed to fetch speaker: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getSponsors() async {
    try {
      final result =
          await functions.httpsCallable('getSponsors').call<List<Object?>>();

      return (result.data as List)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    } catch (e) {
      log('Error fetching sponsors: $e', name: 'ConfCloudFunctionsDataSource');
      throw ConfCloudFunctionsException('Failed to fetch sponsors: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserById(String id) async {
    try {
      final callable = functions.httpsCallable('getUser');
      final result = await callable.call<Map<String, dynamic>>({'userId': id});

      final data = result.data;

      if (data.containsKey('error')) {
        throw ConfGetUserException(data['error'] as String);
      }

      return Map<String, dynamic>.from(data);
    } catch (e) {
      log('Error fetching user: $e', name: 'ConfCloudFunctionsDataSource');
      throw ConfGetUserException('Failed to fetch user: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> createUser(Map<String, dynamic> data) async {
    try {
      final callable = functions.httpsCallable('createUser');
      final result = await callable.call<Map<String, dynamic>>(data);
      final response = result.data;
      final success = response['success'] == true;

      if (!success) {
        throw const ConfCreateUserException();
      }
      return Map<String, dynamic>.from(response['user'] as Map);
    } catch (e) {
      log('Error creating user: $e', name: 'ConfCloudFunctionsDataSource');
      throw ConfCreateUserException('Failed to create user: $e');
    }
  }
}
