import 'package:flutter/material.dart';
import 'package:nike/common/http_client.dart';
import 'package:nike/data/entity/auth_info.dart';
import 'package:nike/data/source/auth_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClint));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> signUp(String username, String password);
  Future<void> refReshToken();
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthInfo?> authChangeNotifier =
      ValueNotifier(null);
  final IAuthDataSource dataSource;
  AuthRepository(
    this.dataSource,
  );
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    _persisAuthTokens(authInfo);
    debugPrint(authInfo.accessToken);
  }

  @override
  Future<void> signUp(String username, String password) async {
    try {
      final AuthInfo authInfo = await dataSource.signUp(username, password);
      _persisAuthTokens(authInfo);
      debugPrint(authInfo.accessToken);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> refReshToken() async {
    final AuthInfo authInfo = await dataSource.refreshToken(
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjAyYmE1NjVmNGZlYWVmNmIzMDQwZmE3NmU4ZTVlZjQzZTg1YjdkYjM3ZDFjMzBkNDEzM2ViNDFiYjk4N2Zk…");
    _persisAuthTokens(authInfo);
  }

  Future<void> _persisAuthTokens(AuthInfo authInfo) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("acces_token", authInfo.accessToken);
    sharedPreferences.setString("refresh_token", authInfo.refreshToken);
  }

  Future<void> laodAuthInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final String accessToken = sharedPreferences.getString("acces_token") ?? "";
    final String refreashToken =
        sharedPreferences.getString("refresh_token") ?? "";

    if (accessToken.isNotEmpty && refreashToken.isNotEmpty) {
      authChangeNotifier.value = AuthInfo(accessToken, refreashToken);
    }
  }
}
