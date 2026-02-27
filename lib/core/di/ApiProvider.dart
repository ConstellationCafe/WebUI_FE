
import 'package:constellation_cafe/core/di/DioProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/network/discordBot/Translator.dart';
import 'package:constellation_cafe/core/network/auth/Interface.dart';
import 'package:constellation_cafe/core/network/auth/OAuthService.dart';
import 'package:constellation_cafe/data/api/discordBot/MembershipAPI.dart';
import 'package:constellation_cafe/data/api/discordBot/ShadowverseAPI.dart';
import 'package:constellation_cafe/data/api/auth/Jwt.dart';
import 'package:constellation_cafe/data/api/auth/Login.dart';


// Network
final _oauthProvider = Provider<AuthServiceInterface>((ref) {
  final dio = ref.watch(dioProvider);
  return OAuthService(dio: dio);
});
final _apiTranslatorProvider = Provider((ref) => APITranslator());

// API
final jwtApiProvider = Provider(
    (ref) => Jwt(ref.read(_oauthProvider))
);
final loginApiProvider = Provider<Login>(
      (ref) => Login(ref.read(_oauthProvider)),
);
final shadowverseApiProvider = Provider(
    (ref) => ShadowverseAPI(ref.read(_apiTranslatorProvider)),
);
final membershipApiProvider = Provider(
    (ref) => MembershipAPI(ref.read(_apiTranslatorProvider))
);

