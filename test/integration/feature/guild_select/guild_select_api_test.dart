import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/guild_select/data/api/guild_api.dart';
import 'package:constellation_cafe/feature/guild_select/data/dto/response/guild_response.dart';

import '../../../support/fake_backend.dart';
import '../../../support/feature/guild_select/support/guild_fixtures.dart';

void main() {
  late FakeBackend backend;
  late GuildApi api;

  setUp(() {
    backend = FakeBackend();
    api = GuildApi(dio: backend.dio);
  });

  tearDown(() => backend.close());

  group('findAll', () {
    test('선택 가능한 채팅방 목록을 도메인 모델로 변환한다', () async {
      backend.reply(
        'GET',
        '/auth/guilds',
        ok([guildJson('1', '별자리'), guildJson('2', '은하수')]),
      );

      final guilds = await api.findAll();

      expect(backend.last.method, 'GET');
      expect(guilds.map((guild) => guild.id), ['1', '2']);
      expect(guilds.first.name, '별자리');
      expect(guilds.first.memberCount, 12);
    });

    test('빈 응답과 null 응답은 빈 목록이다', () async {
      backend.reply('GET', '/auth/guilds', ok([]));
      expect(await api.findAll(), isEmpty);

      backend.reply('GET', '/auth/guilds', ok(null));
      expect(await api.findAll(), isEmpty);
    });

    test('실패 응답은 서버 메시지를 담은 예외로 바꾼다', () async {
      backend.reply('GET', '/auth/guilds', failure(400, '잘못된 요청'));

      await expectLater(
        api.findAll(),
        throwsA(predicate((e) => '$e'.contains('잘못된 요청'))),
      );
    });
  });

  group('selectGuild', () {
    test('선택한 guildId를 본문으로 보내고 성공 여부를 반환한다', () async {
      backend.reply('POST', '/auth/guild/select', ok(null));

      final selected = await api.selectGuild('987');

      expect(selected, isTrue);
      expect(backend.last.method, 'POST');
      expect(backend.last.data, {'guildId': '987'});
    });

    test('403 응답은 선택할 수 없는 방으로 false를 반환한다', () async {
      backend.reply(
        'POST',
        '/auth/guild/select',
        failure(403, 'GUILD_MEMBER_NOT_FOUND'),
        status: 403,
      );

      expect(await api.selectGuild('987'), isFalse);
    });

    test('403이 아닌 서버 오류는 호출부로 전달한다', () async {
      backend.reply(
        'POST',
        '/auth/guild/select',
        failure(500, 'boom'),
        status: 500,
      );

      await expectLater(api.selectGuild('987'), throwsA(isA<DioException>()));
    });
  });

  test('누락된 필드는 안전한 기본값으로 읽는다', () {
    final guild = GuildResponse.fromJson(const {'id': 7}).toDomain();

    expect(guild.id, '7');
    expect(guild.name, '');
    expect(guild.iconUrl, '');
    expect(guild.memberCount, 0);
  });
}
