import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:constellation_cafe/feature/auth/data/repository/jwt.dart';
import 'package:constellation_cafe/feature/auth/data/repository/login.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/auth/notifier/login_check_notifier.dart';
import 'package:constellation_cafe/feature/guild_select/constants/guild_select_strings.dart';
import 'package:constellation_cafe/feature/guild_select/data/api/guild_api.dart';
import 'package:constellation_cafe/feature/guild_select/data/dto/response/guild_response.dart';
import 'package:constellation_cafe/feature/guild_select/domain/guild.dart';
import 'package:constellation_cafe/feature/guild_select/notifier/guild_state_notifier.dart';
import 'package:constellation_cafe/feature/guild_select/pages/guild_select.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/guild_tile/fallback_guild_icon.dart';
import 'package:constellation_cafe/feature/module_config/data/repository/module_config_repository_provider.dart';
import 'package:constellation_cafe/feature/modules/academy/data/api/academy_api.dart';
import 'package:constellation_cafe/feature/modules/competition/data/repository/competition_repository_provider.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/data/repository/penalty_repository_provider.dart';

import '../../../support/fake_academy_api.dart';
import '../../../support/fake_module_config_repository.dart';
import '../../../support/screen.dart';
import '../../../support/feature/auth/support/fake_auth_service.dart';
import '../../../support/feature/modules/competition/support/fake_competition_repository.dart';
import '../../../support/feature/modules/erp/penalty/support/fake_penalty_repository.dart';
import '../../../support/feature/guild_select/support/guild_fixtures.dart';

/// 위젯 테스트용 채팅방 API. HTTP 계약은 guild_select_api_test에서 검증한다.
class FakeGuildApi extends GuildApi {
  FakeGuildApi(this.guilds) : super(dio: Dio());

  final List<Guild>? guilds;
  bool selectable = true;
  Completer<bool>? pendingSelection;
  final List<String> selected = [];

  @override
  Future<List<Guild>> findAll() async {
    final result = guilds;
    if (result == null) throw Exception('API error: boom');
    return result;
  }

  @override
  Future<bool> selectGuild(String guildId) async {
    selected.add(guildId);
    final pending = pendingSelection;
    if (pending != null) return pending.future;
    return selectable;
  }
}

List<Guild> guilds(List<String> names) {
  return [
    for (final (index, name) in names.indexed)
      GuildResponse.fromJson(guildJson('${index + 1}', name)).toDomain(),
  ];
}

class GuildHarness {
  GuildHarness(this.api) {
    container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        guildApiProvider.overrideWithValue(api),
        jwtApiProvider.overrideWithValue(Jwt(auth)),
        loginApiProvider.overrideWithValue(Login(auth)),
        academyApiProvider.overrideWithValue(FakeAcademyApi()),
        moduleConfigRepositoryProvider.overrideWithValue(
          FakeModuleConfigRepository(),
        ),
        competitionRepositoryProvider.overrideWithValue(
          FakeCompetitionRepository(),
        ),
        penaltyRepositoryProvider.overrideWithValue(FakePenaltyRepository()),
      ],
    );
  }

  final FakeGuildApi api;
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
}

Future<GuildHarness> pumpGuildPage(
  WidgetTester tester,
  List<Guild>? guilds,
) async {
  setScreenSize(tester, const Size(1400, 1000));
  final harness = GuildHarness(FakeGuildApi(guilds));
  addTearDown(harness.container.dispose);
  await tester.pumpWidget(harness.app());
  await tester.pumpAndSettle();
  return harness;
}

void main() {
  testWidgets('채팅방 목록과 안내 문구를 보여준다', (tester) async {
    await pumpGuildPage(tester, guilds(['별자리', '은하수']));

    expect(find.text('사용할 채팅방을 선택해주세요'), findsOneWidget);
    expect(find.text('별자리'), findsOneWidget);
    expect(find.text('은하수'), findsOneWidget);
    expect(find.text('12명'), findsNWidgets(2));
    expect(find.byType(FallbackGuildIcon), findsNWidgets(2));
    expect(find.text('안전한 ERP 서비스를 위해 인증된 채팅방만 표시됩니다.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('선택할 수 있는 채팅방이 없으면 빈 상태를 안내한다', (tester) async {
    await pumpGuildPage(tester, const []);

    expect(find.text('사용할 수 있는 채팅방이 없습니다.'), findsOneWidget);
    expect(find.text('ERP 서비스를 이용할 수 있는 채팅방이 없습니다.'), findsOneWidget);
  });

  testWidgets('목록 조회에 실패하면 오류 문구를 보여준다', (tester) async {
    await pumpGuildPage(tester, null);

    expect(find.text('길드 목록을 불러오지 못했습니다.'), findsOneWidget);
  });

  testWidgets('멤버가 아닌 채팅방을 고르면 이동하지 않고 안내한다', (tester) async {
    final harness = await pumpGuildPage(tester, guilds(['별자리']));
    harness.api.selectable = false;

    await tester.tap(find.text('별자리'));
    await tester.pumpAndSettle();

    expect(find.text('이 채팅방을 선택할 수 없습니다. 멤버 여부를 확인해주세요.'), findsOneWidget);
    expect(harness.container.read(currentGuildStateProvider).guildId, isEmpty);
    expect(find.text('home 1'), findsNothing);
  });

  testWidgets('채팅방을 고르면 로그인 상태와 사용자 정보를 갱신하고 홈으로 이동한다', (tester) async {
    final harness = await pumpGuildPage(tester, guilds(['별자리']));
    harness.auth.checks.addAll([
      checkResponse(isLogin: true),
      checkResponse(isLogin: true, roomSelected: true),
    ]);
    harness.container.listen(loginCheckProvider, (_, _) {});
    await tester.pumpAndSettle();

    await tester.tap(find.text('별자리'));
    await tester.pumpAndSettle();

    final guild = harness.container.read(currentGuildStateProvider);
    expect(harness.api.selected, ['1']);
    expect(guild.guildId, '1');
    expect(guild.guildName, '별자리');
    expect(harness.auth.checkCalls, 2);
    expect(harness.auth.meCalls, 1);
    expect(harness.container.read(currentUserStateProvider).userId, '123');
    expect(find.text('home 1'), findsOneWidget);
  });

  testWidgets('연결 중에는 중복 선택을 막고 진행 상태를 표시한다', (tester) async {
    final harness = await pumpGuildPage(tester, guilds(['별자리', '은하수']));
    final pending = Completer<bool>();
    harness.api.pendingSelection = pending;
    harness.auth.checks.addAll([
      checkResponse(isLogin: true),
      checkResponse(isLogin: true, roomSelected: true),
    ]);
    harness.container.listen(loginCheckProvider, (_, _) {});
    await tester.pumpAndSettle();

    await tester.tap(find.text('별자리'));
    await tester.pump();
    expect(find.text(GuildSelectStrings.connecting), findsOneWidget);
    await tester.tap(find.text('은하수'), warnIfMissed: false);
    expect(harness.api.selected, ['1']);

    pending.complete(true);
    await tester.pumpAndSettle();
    expect(find.text('home 1'), findsOneWidget);
    expect(harness.auth.meCalls, 1);
  });

  testWidgets('채팅방을 다시 고를 때도 사용자 정보를 한 번만 다시 읽는다', (tester) async {
    final harness = await pumpGuildPage(tester, guilds(['별자리']));
    await harness.container
        .read(currentUserStateProvider.notifier)
        .initialize();
    harness.container.read(currentUserStateProvider.notifier).update(roles: []);
    harness.auth.checks.addAll([
      checkResponse(isLogin: true),
      checkResponse(isLogin: true, roomSelected: true),
    ]);
    harness.container.listen(loginCheckProvider, (_, _) {});
    await tester.pumpAndSettle();

    await tester.tap(find.text('별자리'));
    await tester.pumpAndSettle();

    expect(harness.auth.meCalls, 2, reason: '기존 초기화 1회와 새 채팅방 초기화 1회');
    expect(harness.container.read(currentUserStateProvider).roles, [
      'ROLE_ADMIN',
    ]);
    expect(find.text('home 1'), findsOneWidget);
  });
}
