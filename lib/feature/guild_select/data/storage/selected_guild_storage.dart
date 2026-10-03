import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../state/guild_state.dart';

final selectedGuildStorageProvider = Provider<SelectedGuildStorage>(
  (ref) => const SelectedGuildStorage(),
);

/// 마지막으로 선택한 채팅방을 브라우저 저장소에 보관한다.
///
/// 채팅방을 고르면 서버가 그 방(botId)이 담긴 토큰을 cookie로 재발급하므로, 브라우저를
/// 새로고침해도 토큰은 그 방을 가리킨다. 반면 화면의 채팅방 상태는 메모리에만 있어
/// 새로고침하면 비고, 헤더의 채팅방 로고·이름이 사라졌다. 같은 방 정보를 저장해 두고
/// 앱이 다시 시작될 때 복원한다. 비밀값이 아닌 공개 식별자·이름·아이콘 URL만 담는다.
class SelectedGuildStorage {
  static const _idKey = 'selected_guild.id';
  static const _nameKey = 'selected_guild.name';
  static const _iconKey = 'selected_guild.icon';

  const SelectedGuildStorage();

  /// 저장된 채팅방. 없거나 읽을 수 없으면 null.
  Future<CurrentGuildState?> read() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString(_idKey);
      final name = prefs.getString(_nameKey);
      if (id == null || id.isEmpty || name == null) return null;
      return CurrentGuildState(
        guildId: id,
        guildName: name,
        guildIcon: prefs.getString(_iconKey),
      );
    } catch (_) {
      // 저장소를 쓸 수 없는 환경(사생활 보호 모드 등)에서는 복원 없이 동작한다.
      return null;
    }
  }

  Future<void> save(CurrentGuildState guild) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_idKey, guild.guildId);
      await prefs.setString(_nameKey, guild.guildName);
      final icon = guild.guildIcon;
      if (icon == null || icon.isEmpty) {
        await prefs.remove(_iconKey);
      } else {
        await prefs.setString(_iconKey, icon);
      }
    } catch (_) {
      // 저장 실패는 새로고침 후 복원만 못 할 뿐 현재 화면에는 영향이 없다.
    }
  }

  Future<void> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_idKey);
      await prefs.remove(_nameKey);
      await prefs.remove(_iconKey);
    } catch (_) {
      // 위와 같은 이유로 무시한다.
    }
  }
}
