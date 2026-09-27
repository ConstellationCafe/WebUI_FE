import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/shared/data/dto/response/backend/ApiResponse.dart';
import 'package:constellation_cafe/feature/auth/api/auth_Interface.dart';
import 'package:constellation_cafe/feature/auth/api/auth_service_provider.dart';

final jwtApiProvider = Provider((ref) => Jwt(ref.read(oauthServiceProvider)));

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
