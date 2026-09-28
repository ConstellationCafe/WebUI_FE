import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/auth/notifier/login_check_notifier.dart';
import 'package:constellation_cafe/feature/auth/service/jwt.dart';
import 'package:constellation_cafe/feature/auth/service/login.dart';
import 'package:constellation_cafe/feature/guild_select/api/guild_api.dart';
import 'package:constellation_cafe/feature/guild_select/notifier/guild_state_notifier.dart';
import 'package:constellation_cafe/feature/guild_select/page/guild_select.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/guild_tile/fallback_guild_icon.dart';
import 'package:constellation_cafe/feature/modules/academy/data/api/academy_api.dart';

import '../../support/fake_backend.dart';
import '../auth/support/fake_auth_service.dart';
import 'support/guild_fixtures.dart';

class GuildHarness {
  GuildHarness() {
    backend.reply(
      'GET',
      '/api/academy/me/permissions',
      ok({'admin': false, 'academies': []}),
    );
    container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        guildApiProvider.overrideWithValue(GuildApi(dio: backend.dio)),
        jwtApiProvider.overrideWithValue(Jwt(auth)),
        loginApiProvider.overrideWithValue(Login(auth)),
        academyApiProvider.overrideWithValue(AcademyApi(dio: backend.dio)),
      ],
    );
  }

  final FakeBackend backend = FakeBackend();
  final FakeAuthService auth = FakeAuthService();
  late final ProviderContainer container;

  late final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (_, _) => const GuildSelectPage()),
      GoRoute(
        path: '/home',
        builder: (_, state) {
          final guildId = state.uri.queryParameters['guild_id'];
          return Scaffold(body: Text('home $guildId'));
        },
      ),
    ],
  );

  Widget app() => UncontrolledProviderScope(
    container: container,
    child: MaterialApp.router(
      theme: CustomTheme.themeData,
      routerConfig: router,
    ),
  );

  void dispose() {
    container.dispose();
    backend.close();
  }
}

Future<GuildHarness> pumpGuildPage(WidgetTester tester, Object? body) async {
  await tester.binding.setSurfaceSize(const Size(1400, 1000));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  final harness = GuildHarness();
  addTearDown(harness.dispose);
  harness.backend.reply('GET', '/auth/guilds', body);
  await tester.pumpWidget(harness.app());
  await tester.pumpAndSettle();
  return harness;
}

void main() {
  testWidgets('채팅방 목록과 안내 문구를 보여준다', (tester) async {
    await pumpGuildPage(
      tester,
      ok([guildJson('1', '별자리'), guildJson('2', '은하수')]),
    );

    expect(find.text('사용할 채팅방을 선택해주세요'), findsOneWidget);
    expect(find.text('별자리'), findsOneWidget);
    expect(find.text('은하수'), findsOneWidget);
    expect(find.text('12명'), findsNWidgets(2));
    expect(find.byType(FallbackGuildIcon), findsNWidgets(2));
    expect(find.text('안전한 ERP 서비스를 위해 인증된 채팅방만 표시됩니다.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('선택할 수 있는 채팅방이 없으면 빈 상태를 안내한다', (tester) async {
    await pumpGuildPage(tester, ok([]));

    expect(find.text('사용할 수 있는 채팅방이 없습니다.'), findsOneWidget);
    expect(find.text('ERP 서비스를 이용할 수 있는 채팅방이 없습니다.'), findsOneWidget);
  });

  testWidgets('목록 조회에 실패하면 오류 문구를 보여준다', (tester) async {
    await pumpGuildPage(tester, failure(500, 'boom'));

    expect(find.text('길드 목록을 불러오지 못했습니다.'), findsOneWidget);
  });

  testWidgets('멤버가 아닌 채팅방을 고르면 이동하지 않고 안내한다', (tester) async {
    final harness = await pumpGuildPage(tester, ok([guildJson('1', '별자리')]));
    harness.backend.reply(
      'POST',
      '/auth/guild/select',
      failure(403, 'GUILD_MEMBER_NOT_FOUND'),
      status: 403,
    );

    await tester.tap(find.text('별자리'));
    await tester.pumpAndSettle();

    expect(find.text('이 채팅방을 선택할 수 없습니다. 멤버 여부를 확인해주세요.'), findsOneWidget);
    expect(harness.container.read(currentGuildStateProvider).guildId, isEmpty);
    expect(find.text('home 1'), findsNothing);
  });

  testWidgets('채팅방을 고르면 로그인 상태와 사용자 정보를 갱신하고 홈으로 이동한다', (tester) async {
    final harness = await pumpGuildPage(tester, ok([guildJson('1', '별자리')]));
    harness.backend.reply('POST', '/auth/guild/select', ok(null));
    harness.auth.checks.addAll([
      checkResponse(isLogin: true),
      checkResponse(isLogin: true, roomSelected: true),
    ]);
    harness.container.listen(loginCheckProvider, (_, _) {});
    await tester.pumpAndSettle();

    await tester.tap(find.text('별자리'));
    await tester.pumpAndSettle();

    final guild = harness.container.read(currentGuildStateProvider);
    expect(guild.guildId, '1');
    expect(guild.guildName, '별자리');
    expect(harness.auth.checkCalls, 2);
    expect(harness.container.read(currentUserStateProvider).userId, '123');
    expect(find.text('home 1'), findsOneWidget);
  });
}
