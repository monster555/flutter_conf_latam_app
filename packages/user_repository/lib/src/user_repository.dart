import 'package:conf_data_source/conf_data_source.dart';
import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:user_repository/user_repository.dart';

class UserRepository implements IUserRepository {
  UserRepository({required ConfDataSource dataSource})
      : _dataSource = dataSource;

  final ConfDataSource _dataSource;

  @override
  FutureUserResult create(Map<String, dynamic> data) async {
    try {
      final json = await _dataSource.createUser(data);
      if (json == null) return const Failure(ConfCreateUserException());
      return Success(User.fromJson(json));
    } on ConfUserDataSourceException catch (e) {
      return Failure(e);
    }
  }

  @override
  FutureUserResult get(String id) async {
    try {
      final json = await _dataSource.getUserById(id);
      if (json == null) return const Failure(ConfGetUserException());
      return Success(User.fromJson(json));
    } on ConfUserDataSourceException catch (e) {
      return Failure(e);
    }
  }
}
