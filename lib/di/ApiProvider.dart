
import 'package:constellation_cafe/di/DioProvider.dart';
import 'package:constellation_cafe/feature/contents/academy/api/student_status_api.dart';
import 'package:constellation_cafe/feature/contents/academy/api/academy_api.dart';
import 'package:constellation_cafe/feature/guild_select/api/guild_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/network/discordBot/Translator.dart';
import 'package:constellation_cafe/feature/auth/api/auth_Interface.dart';
import 'package:constellation_cafe/feature/auth/api/oauth_service.dart';
import 'package:constellation_cafe/feature/contents/friendly_match/api/shadowverse_api.dart';
import 'package:constellation_cafe/feature/profile/api/membership_api.dart';
import 'package:constellation_cafe/feature/auth/service/jwt.dart';
import 'package:constellation_cafe/feature/auth/service/login.dart';

import '../feature/contents/academy/api/lesson_record_api.dart';


// Network
final _oauthProvider = Provider<AuthServiceInterface>((ref) {
    final dio = ref.watch(dioProvider);
    // ErrorInterceptor는 DioProvider에서 이미 추가됨
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
final guildApiProvider = Provider((ref) {
    final dio = ref.watch(dioProvider);
    return GuildApi(dio: dio);
});
final shadowverseApiProvider = Provider(
    (ref) => ShadowverseAPI(ref.read(_apiTranslatorProvider)),
);
final membershipApiProvider = Provider(
    (ref) => MembershipAPI(ref.read(_apiTranslatorProvider))
);
final academyApiProvider = Provider((ref) {
    final dio = ref.watch(dioProvider);
    return AcademyApi(dio: dio);
});
final lessonRecordApiProvider = Provider((ref) {
    final dio = ref.watch(dioProvider);
    return LessonRecordApi(dio: dio);
});
final studentStatusApiProvider = Provider((ref) {
    final dio = ref.watch(dioProvider);
    return StudentStatusApi(dio: dio);
});