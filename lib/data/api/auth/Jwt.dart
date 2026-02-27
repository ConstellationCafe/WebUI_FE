import 'package:constellation_cafe/data/model/response/backend/ApiResponse.dart';
import 'package:constellation_cafe/core/network/auth/Interface.dart';


class Jwt {
  final AuthServiceInterface authService;

  Jwt(this.authService);

  Future<ApiResponse> check() async {
    return authService.check();
  }

  Future<bool> refresh() async {
    return authService.refresh();
  }
}