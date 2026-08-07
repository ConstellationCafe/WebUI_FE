
import 'package:constellation_cafe/feature/auth/service/auth_Interface.dart';
import 'package:constellation_cafe/feature/auth/domain/method/login_method.dart';
import 'package:constellation_cafe/shared/model/response/backend/ApiResponse.dart';

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