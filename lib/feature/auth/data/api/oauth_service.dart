import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:constellation_cafe/core/network/network_timeouts.dart';
import 'package:constellation_cafe/feature/auth/data/api/auth_interface.dart';
import 'package:constellation_cafe/feature/auth/data/api/discord_login.dart';
import 'package:constellation_cafe/feature/auth/domain/method/login_method.dart';
import 'package:constellation_cafe/shared/data/dto/response/backend/api_response.dart';

class OAuthService implements AuthServiceInterface {
  /// WebUI_BE 주소. 값은 --dart-define으로 주입한다(docs/deploy.md).
  static const base = String.fromEnvironment('BACKEND_URI');
  static const _jsonHeaders = {"Accept": "application/json"};

  final DiscordLogin discordLogin = DiscordLogin();
  final Dio dio;

  OAuthService({required this.dio});

  // LoginMethodType에 따라 알맞는 login 호출
  @override
  Future<void> login(LoginMethodType loginMethod) async {
    switch (loginMethod) {
      case LoginMethodType.discord:
        discordLogin.login();
        break;
    }
  }

  @override
  Future<void> logout() async {
    await http
        .post(Uri.parse("$base/auth/logout"), headers: _jsonHeaders)
        .timeout(NetworkTimeouts.authRequest);
  }

  @override
  Future<ApiResponse> me() async {
    // refresh가 필요한 요청이라 dio 객체 사용
    final res = await dio.get("$base/auth/me");
    return ApiResponse.fromDioResponse(res);
  }

  // check·refresh는 로그인 확인 흐름(LoginCheckNotifier)이 결과를 직접 판단하므로
  // AuthInterceptor의 자동 갱신과 전역 오류 SnackBar를 거치지 않는 http를 쓴다.
  @override
  Future<ApiResponse> check() async {
    final http.Response res = await http
        .get(Uri.parse("$base/auth/check"), headers: _jsonHeaders)
        .timeout(NetworkTimeouts.authRequest);
    return ApiResponse.fromHttpResponse(res);
  }

  @override
  Future<bool> refresh() async {
    try {
      final res = await http
          .post(Uri.parse('$base/auth/refresh'), headers: _jsonHeaders)
          .timeout(NetworkTimeouts.authRequest);
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
