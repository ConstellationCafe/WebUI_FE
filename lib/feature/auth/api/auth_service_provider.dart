import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/network/dio_provider.dart';

import 'auth_interface.dart';
import 'oauth_service.dart';

/// [Jwt], [Login] 등 인증 관련 서비스가 공유하는 [AuthServiceInterface] 구현체.
final oauthServiceProvider = Provider<AuthServiceInterface>((ref) {
  final dio = ref.watch(dioProvider);
  // ErrorInterceptor는 DioProvider에서 이미 추가됨
  return OAuthService(dio: dio);
});
