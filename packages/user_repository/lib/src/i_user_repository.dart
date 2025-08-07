import 'package:conf_data_source/conf_data_source.dart';
import 'package:conf_shared_models/conf_shared_models.dart';

typedef FutureUserResult = FutureResult<User, ConfUserDataSourceException>;

abstract interface class IUserRepository {
  FutureUserResult get(String id);
  FutureUserResult create(Map<String, dynamic> data);
}
