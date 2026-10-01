import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/feature/auth/data/api/auth_interface.dart';
import 'package:constellation_cafe/feature/auth/data/api/auth_service_provider.dart';
import 'package:constellation_cafe/shared/data/dto/response/backend/api_response.dart';

final jwtApiProvider = Provider((ref) => Jwt(ref.watch(oauthServiceProvider)));

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
