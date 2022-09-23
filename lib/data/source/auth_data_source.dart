import 'package:dio/dio.dart';
import 'package:nike/data/common/constans.dart';
import 'package:nike/data/common/http_response_validator.dart';
import 'package:nike/data/entity/auth_info.dart';

abstract class IAuthDataSource {
  Future<AuthInfo> login(String username, String password);
  Future<AuthInfo> signUp(String username, String password);
  Future<AuthInfo> refreshToken(String token);
}

class AuthRemoteDataSource
    with HttpResponseValidator
    implements IAuthDataSource {
  final Dio httpClient;
  AuthRemoteDataSource(this.httpClient);
  @override
  Future<AuthInfo> login(String username, String password) async {
    final respone = await httpClient.post('auth/token', data: {
      "grant_type": "password",
      "client_id": 2,
      "client_secret": Constans.clientSecret,
      "username": username,
      "password": password
    });
    validateResponse(respone);
    return AuthInfo(
        respone.data["access_token"], respone.data["refresh_token"]);
  }

  @override
  Future<AuthInfo> refreshToken(String token) {
    throw UnimplementedError();
  }

  @override
  Future<AuthInfo> signUp(String username, String password) async {
    final respone = await httpClient
        .post('user/register', data: {"email": username, "password": password});
    validateResponse(respone);

    return login(username, password);
  }
}
