
import 'package:constellation_cafe/core/network/auth/Interface.dart';
import 'package:constellation_cafe/domain/Login/Method/LoginMethod.dart';
import 'package:constellation_cafe/data/model/response/backend/ApiResponse.dart';

class Login {
  final AuthServiceInterface oauthService;

  Login(this.oauthService);

  Future<void> discordLogin() async {
    await oauthService.login(LoginMethodType.discord);
  }

  Future<void> logout() async {
    await oauthService.logout();
  }

  Future<ApiResponse> me() async {
    return await oauthService.me();
  }
}