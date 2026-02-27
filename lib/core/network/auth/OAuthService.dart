
import 'package:constellation_cafe/core/network/auth/Interface.dart';
import 'package:constellation_cafe/core/network/auth/discord/DiscordLogin.dart';
import 'package:constellation_cafe/data/model/response/backend/ApiResponse.dart';
import 'package:constellation_cafe/domain/Login/Method/LoginMethod.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;


class OAuthService implements AuthServiceInterface {
  static const base = "https://constellationcafe.p-e.kr/auth";
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
    await http.post(
      Uri.parse("$base/logout"),
      headers: {"Accept": "application/json"},
    );
  }

  @override
  Future<ApiResponse> me() async {
    // refresh가 필요한 요청이라 dio 객체 사용
    final res = await dio.get("$base/me");
    return ApiResponse.fromDioResponse(res);
  }

  // LoginMethodType에 관계없이 공통
  @override
  Future<ApiResponse> check() async {
    final http.Response res = await http.get(
      Uri.parse("$base/check"),
      headers: {"Accept": "application/json"},
    );
    return ApiResponse.fromHttpResponse(res);
  }

  // FIXME : 이거 AuthStateProvider 때문에 남겨둔 코드, 제거 필요
  @override
  Future<bool> refresh() async {
    try {
      final res = await http.post(
          Uri.parse('$base/refresh'),
          headers: {"Accept": "application/json"}
      );
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}