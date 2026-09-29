import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/feature/auth/data/api/auth_interface.dart';
import 'package:constellation_cafe/feature/auth/data/api/auth_service_provider.dart';
import 'package:constellation_cafe/feature/auth/domain/method/login_method.dart';
import 'package:constellation_cafe/shared/data/dto/response/backend/api_response.dart';

final loginApiProvider = Provider<Login>(
  (ref) => Login(ref.watch(oauthServiceProvider)),
);

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
