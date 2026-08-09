import 'package:constellation_cafe/shared/model/response/backend/ApiResponse.dart';
import 'package:constellation_cafe/feature/auth/api/auth_Interface.dart';


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