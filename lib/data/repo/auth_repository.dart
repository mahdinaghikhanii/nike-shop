import 'package:nike/common/http_client.dart';
import 'package:nike/data/source/auth_data_source.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClint));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;
  AuthRepository(this.dataSource);
  @override
  Future<void> login(String username, String password) {
    return dataSource.login(username, password);
  }
}
