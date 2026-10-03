import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/storage/selected_guild_storage.dart';
import 'guild_state_notifier.dart';

/// 선택한 채팅방을 브라우저 저장소와 맞춘다. 앱 수명 동안 유지되며 `MyApp`에서 구독한다.
///
/// - 시작 시: 저장된 채팅방이 있고 아직 고른 방이 없으면 화면 상태를 복원한다.
///   (새로고침 뒤 헤더의 채팅방 로고·이름이 비는 문제)
/// - 이후: 채팅방을 고르면 저장하고, 로그아웃 등으로 비면 저장소도 지운다.
///
/// 저장된 방이 서버 토큰의 방과 다를 수 있는 경우(다른 계정 로그인 등)에도 라우터가
/// `/auth/check`로 채팅방 선택 여부를 다시 확인하고, 다시 고르면 덮어쓴다.
final selectedGuildPersistenceProvider = Provider<void>((ref) {
  final storage = ref.watch(selectedGuildStorageProvider);

  ref.listen(currentGuildStateProvider, (previous, next) {
    if (next.guildId.isEmpty) {
      if (previous != null && previous.guildId.isNotEmpty) {
        unawaited(storage.clear());
      }
      return;
    }
    if (previous == next) return;
    unawaited(storage.save(next));
  });

  unawaited(_restore(ref, storage));
});

Future<void> _restore(Ref ref, SelectedGuildStorage storage) async {
  final saved = await storage.read();
  if (saved == null || !ref.mounted) return;
  // 복원을 기다리는 사이 사용자가 이미 채팅방을 골랐다면 그 선택이 우선이다.
  if (ref.read(currentGuildStateProvider).guildId.isNotEmpty) return;
  ref
      .read(currentGuildStateProvider.notifier)
      .setGuild(
        guildId: saved.guildId,
        guildName: saved.guildName,
        guildIcon: saved.guildIcon ?? '',
      );
}
