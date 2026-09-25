import 'package:dio/dio.dart';
import '../domain/guild.dart';

class GuildApi {
  static const base = String.fromEnvironment('BACKEND_URI');
  final Dio dio;

  GuildApi({required this.dio});

  @override
  Future<List<Guild>> findAll() async {
    final response = await dio.get("$base/auth/guilds");
    final res = response.data;
    if (res['success'] == true) {
      final List entities = (res['response'] as List?)?.toList() ?? const [];
      if (entities.isNotEmpty) {
        return entities.map((e) => Guild.fromJson(e)).toList();
      } else {
        return [];
      }
    } else {
      final err = res['error'];
      final msg = (err is Map<String, dynamic>)
          ? (err['message']?.toString() ?? 'unknown')
          : 'unknown';
      throw Exception('API error: $msg');
    }
  }

  /// ADR-0001: 채팅방(guildId)을 선택해야 로그인이 완료된다.
  /// 성공하면 백엔드가 botId가 담긴 AccessToken/RefreshToken을 재발급한다.
  /// 등록되지 않은 방(403 GUILD_NOT_REGISTERED)이거나, 등록은 되어 있지만
  /// 이 사용자가 멤버가 아닌 방(403 GUILD_MEMBER_NOT_FOUND)이면 false를
  /// 반환한다 — 두 경우 모두 호출부에서는 "선택할 수 없는 방"으로 동일하게
  /// 처리하면 된다.
  Future<bool> selectGuild(String guildId) async {
    try {
      final response = await dio.post(
        "$base/auth/guild/select",
        data: {"guildId": guildId},
      );
      final res = response.data;
      return res is Map<String, dynamic> && res['success'] == true;
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (status == 403) {
        return false;
      }
      rethrow;
    }
  }
}
