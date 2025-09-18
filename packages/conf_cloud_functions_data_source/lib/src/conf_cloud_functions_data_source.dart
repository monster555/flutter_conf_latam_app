import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:conf_cloud_functions_data_source/src/conf_cloud_functions_exception.dart';
import 'package:conf_data_source/conf_data_source.dart';

class ConfCloudFunctionsDataSource implements ConfDataSource {
  ConfCloudFunctionsDataSource({FirebaseFunctions? functionsInstance})
    : _functions = functionsInstance ?? FirebaseFunctions.instance;

  static const Duration _defaultTimeout = Duration(seconds: 30);
  static const String _defaultLanguageCode = 'es';

  final FirebaseFunctions _functions;

  @override
  Future<List<Map<String, dynamic>>> getSpeakers({String? languageCode}) async {
    try {
      final result = await _functions
          .httpsCallable('getSpeakers')
          .call<List<Object?>>({'lang': languageCode ?? _defaultLanguageCode})
          .timeout(_defaultTimeout);

      return (result.data as List)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    } catch (e, s) {
      log('Error fetching speakers: $e', name: 'ConfCloudFunctionsDataSource');
      log('Stack: \n$s', name: 'ConfCloudFunctionsDataSource');
      throw ConfCloudFunctionsException('Failed to fetch speakers: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getSpeakerById(
    String id, {
    String? languageCode,
  }) async {
    try {
      final result = await _functions
          .httpsCallable('getSpeakerById')
          .call<Object?>({
            'speakerId': id,
            'lang': languageCode ?? _defaultLanguageCode,
          })
          .timeout(_defaultTimeout);

      return result.data != null
          ? Map<String, dynamic>.from(result.data! as Map)
          : null;
    } catch (e, s) {
      log(
        'Error fetching speaker by ID: $e',
        name: 'ConfCloudFunctionsDataSource',
      );
      log('Stack: \n$s', name: 'ConfCloudFunctionsDataSource');
      throw ConfCloudFunctionsException('Failed to fetch speaker: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getSessions({String? languageCode}) async {
    try {
      final result = await _functions
          .httpsCallable('getConferenceSchedule')
          .call<Object?>({'lang': languageCode ?? _defaultLanguageCode})
          .timeout(_defaultTimeout);

      final responseData = result.data! as Map<Object?, Object?>;
      final scheduleData = Map<String, dynamic>.from(responseData);

      if (scheduleData.containsKey('days')) {
        final days = scheduleData['days'] as List;
        return days.map((dayData) {
          return Map<String, dynamic>.from(dayData as Map);
        }).toList();
      }

      return [scheduleData];
    } catch (e, s) {
      log('Error fetching sessions: $e', name: 'ConfCloudFunctionsDataSource');
      log('Stack: \n$s', name: 'ConfCloudFunctionsDataSource');
      throw ConfCloudFunctionsException('Failed to fetch sessions: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getSponsors() async {
    try {
      final result = await _functions
          .httpsCallable('getSponsors')
          .call<List<Object?>>()
          .timeout(_defaultTimeout);

      return (result.data as List)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    } catch (e, s) {
      log('Error fetching sponsors: $e', name: 'ConfCloudFunctionsDataSource');
      log('Stack: \n$s', name: 'ConfCloudFunctionsDataSource');
      throw ConfCloudFunctionsException('Failed to fetch sponsors: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserById(String id) async {
    try {
      final callable = _functions.httpsCallable('getUser');
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
      final callable = _functions.httpsCallable('createUser');
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
