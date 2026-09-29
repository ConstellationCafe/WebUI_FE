import 'package:constellation_cafe/feature/profile/domain/model/membership.dart';
import 'package:constellation_cafe/shared/data/dto/response/bot/bot_command_response.dart';

/// 빗자루 봇 `MembershipAPI.create_card` 응답.
///
/// `payload.result`는 순서가 정해진 문자열 목록이다:
/// `[username, uid1, uid2, role, coin, s1Data, s2Data, guild, joinAt]`
class MembershipCardResponse {
  final List<String> fields;

  const MembershipCardResponse(this.fields);

  factory MembershipCardResponse.fromJson(Map<String, dynamic> json) {
    final raw = BotCommandResponse.fromJson(json).result as List;
    return MembershipCardResponse(
      List<String>.from(raw.map((e) => e?.toString() ?? '')),
    );
  }

  Membership toDomain({required String avatar}) => Membership(
    username: fields[0],
    uid1: fields[1],
    uid2: fields[2],
    role: fields[3],
    coin: fields[4],
    s1Data: fields[5],
    s2Data: fields[6],
    guild: fields[7],
    joinAt: fields[8],
    avatar: avatar,
  );
}
