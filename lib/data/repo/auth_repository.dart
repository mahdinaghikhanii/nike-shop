import 'package:flutter/material.dart';
import 'package:nike/common/http_client.dart';
import 'package:nike/data/entity/auth_info.dart';
import 'package:nike/data/source/auth_data_source.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClint));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> signUp(String username, String password);
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;
  AuthRepository(this.dataSource);
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    debugPrint(authInfo.accessToken);
  }

  @override
  Future<void> signUp(String username, String password) async {
    try {
      final AuthInfo authInfo = await dataSource.signUp(username, password);
      debugPrint(authInfo.accessToken);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
