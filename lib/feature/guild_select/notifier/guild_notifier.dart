@riverpod
class CurrentGuild extends _$CurrentGuild {
  @override
  CurrentGuildState build() {
    return CurrentGuildState.initial();
  }

  void setGuild(String guildId) {
    state = CurrentGuildState(
      guildId: guildId,
    );
  }

  void clear() {
    state = CurrentGuildState.initial();
  }
}