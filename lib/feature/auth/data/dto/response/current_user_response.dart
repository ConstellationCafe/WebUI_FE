import 'package:constellation_cafe/feature/auth/state/current_user_state.dart';

/// `GET /auth/me` 응답 본문.
class CurrentUserResponse {
  final String discordId;
  final String globalName;
  final List<String> roles;
  final String avatar;

  const CurrentUserResponse({
    required this.discordId,
    required this.globalName,
    required this.roles,
    required this.avatar,
  });

  factory CurrentUserResponse.fromJson(Map<String, dynamic> json) {
    return CurrentUserResponse(
      discordId: json['discordId'] as String,
      globalName: json['globalName'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      avatar: json['avatar'] as String,
    );
  }

  CurrentUserState toState() => CurrentUserState(
    userId: discordId,
    globalName: globalName,
    roles: roles,
    avatarUrl: avatar,
  );
}
