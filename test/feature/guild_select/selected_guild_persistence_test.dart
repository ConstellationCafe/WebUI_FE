import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:constellation_cafe/feature/guild_select/notifier/guild_state_notifier.dart';
import 'package:constellation_cafe/feature/guild_select/notifier/selected_guild_persistence.dart';
import 'package:constellation_cafe/feature/guild_select/state/guild_state.dart';

const _icon = 'https://cdn.example.com/icons/1.png';

Map<String, Object> _saved({String id = '1', String name = '별자리'}) => {
  'selected_guild.id': id,
  'selected_guild.name': name,
  'selected_guild.icon': _icon,
};

ProviderContainer _start() {
  final container = ProviderContainer();
  addTearDown(container.dispose);
  container.read(selectedGuildPersistenceProvider);
  return container;
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('새로고침 뒤 저장된 채팅방으로 헤더 상태를 복원한다', () async {
    SharedPreferences.setMockInitialValues(_saved());

    final container = _start();
    await pumpEventQueue();

    expect(
      container.read(currentGuildStateProvider),
      const CurrentGuildState(guildId: '1', guildName: '별자리', guildIcon: _icon),
    );
  });

  test('저장된 채팅방이 없으면 빈 상태를 유지한다', () async {
    final container = _start();
    await pumpEventQueue();

    expect(container.read(currentGuildStateProvider).guildId, isEmpty);
  });

  test('복원 전에 고른 채팅방은 저장된 값으로 덮어쓰지 않는다', () async {
    SharedPreferences.setMockInitialValues(_saved(id: '9', name: '이전 방'));

    final container = _start();
    container
        .read(currentGuildStateProvider.notifier)
        .setGuild(guildId: '1', guildName: '별자리', guildIcon: _icon);
    await pumpEventQueue();

    expect(container.read(currentGuildStateProvider).guildId, '1');
  });

  test('채팅방을 고르면 저장하고, 로그아웃으로 비우면 저장소도 지운다', () async {
    final container = _start();
    await pumpEventQueue();
    final guild = container.read(currentGuildStateProvider.notifier);

    guild.setGuild(guildId: '2', guildName: '은하수', guildIcon: '');
    await pumpEventQueue();
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('selected_guild.id'), '2');
    expect(prefs.getString('selected_guild.name'), '은하수');
    expect(prefs.containsKey('selected_guild.icon'), isFalse);

    guild.clear();
    await pumpEventQueue();
    expect(prefs.containsKey('selected_guild.id'), isFalse);
    expect(prefs.containsKey('selected_guild.name'), isFalse);
  });
}
