import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/guild_state.dart';
part 'guild_state_notifier.g.dart';

@Riverpod(keepAlive: true)  // 새로고침해도 유지되게
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

  void clear() {
    state = CurrentGuildState.initial();
  }
}