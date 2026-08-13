import 'package:freezed_annotation/freezed_annotation.dart';

part 'guild_state.freezed.dart';

@freezed
abstract class CurrentGuildState with _$CurrentGuildState {
  const factory CurrentGuildState({
    required String guildId,
    required String guildName,
    String? guildIcon,
  }) = _CurrentGuildState;

  factory CurrentGuildState.initial() => const CurrentGuildState(
    guildId: '',
    guildName: ''
  );
}