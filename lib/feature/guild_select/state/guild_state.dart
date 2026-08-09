import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/current_guild_state.dart';
import '../models/guild.dart';

part 'current_guild_provider.g.dart';

@freezed
abstract class CurrentGuildState with _$CurrentGuildState {
  const factory CurrentGuildState({
    required String guildId,
  }) = _CurrentGuildState;

  factory CurrentGuildState.initial() => const CurrentGuildState(
    guildId: "",
  );
}