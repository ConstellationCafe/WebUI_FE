import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/auth/notifier/login_check_notifier.dart';

import '../data/api/guild_api.dart';
import '../domain/guild.dart';
import '../domain/type/guild_selection_result.dart';
import '../state/guild_state.dart';

part 'guild_state_notifier.g.dart';

/// 선택한 채팅방. 화면을 오가도 유지되도록 앱 수명 동안 유지한다.
/// (브라우저 새로고침은 앱을 다시 시작하므로 채팅방 선택 화면에서 다시 고른다.)
@Riverpod(keepAlive: true)
class CurrentGuildStateNotifier extends _$CurrentGuildStateNotifier {
  @override
  CurrentGuildState build() {
    return CurrentGuildState.initial();
  }

  void setGuild({
    required String guildId,
    required String guildName,
    required String guildIcon,
  }) {
    state = CurrentGuildState(
      guildId: guildId,
      guildName: guildName,
      guildIcon: guildIcon,
    );
  }

  /// ADR-0001: 채팅방을 선택해야 로그인이 완료된다.
  ///
  /// 백엔드가 이 discordId를 그 방의 멤버로 확인해줘야 botId가 실린 토큰이
  /// 발급되므로, 로컬 상태만 바꾸고 넘어가면 이후 /api/**가 전부 401난다.
  Future<GuildSelectionResult> select(Guild guild) async {
    bool selected;
    try {
      selected = await ref.read(guildApiProvider).selectGuild(guild.id);
    } catch (_) {
      selected = false;
    }
    if (!selected) return GuildSelectionResult.rejected;

    // 이전 채팅방의 사용자 역할과 학원 권한을 지운 다음,
    // 재확인 과정에서 새 방의 정보를 한 번만 불러온다.
    ref.read(currentUserStateProvider.notifier).clear();
    setGuild(
      guildId: guild.id,
      guildName: guild.name,
      guildIcon: guild.iconUrl,
    );

    // 새로 발급된(botId 포함) 토큰을 기준으로 로그인 상태(roomSelected)를 다시 확인한다.
    final loginCheck = ref.read(loginCheckProvider.notifier);
    await loginCheck.recheck();
    if (ref.read(loginCheckProvider).value?.roomSelected != true) {
      return GuildSelectionResult.checkFailed;
    }
    return GuildSelectionResult.selected;
  }

  void clear() {
    state = CurrentGuildState.initial();
  }
}
