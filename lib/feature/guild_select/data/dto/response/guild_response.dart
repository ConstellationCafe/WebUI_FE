import 'package:constellation_cafe/feature/guild_select/domain/guild.dart';

/// `GET /auth/guilds` 응답의 채팅방 한 건.
class GuildResponse {
  final String id;
  final String name;
  final String iconUrl;
  final int memberCount;

  const GuildResponse({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.memberCount,
  });

  factory GuildResponse.fromJson(Map<String, dynamic> json) {
    return GuildResponse(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      iconUrl: (json['iconUrl'] ?? '').toString(),
      memberCount: (json['memberCount'] ?? 0),
    );
  }

  Guild toDomain() =>
      Guild(id: id, name: name, iconUrl: iconUrl, memberCount: memberCount);
}
