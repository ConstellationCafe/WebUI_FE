import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:constellation_cafe/feature/auth/data/api/discord_login.dart';
import 'package:constellation_cafe/feature/auth/data/api/oauth_service.dart';
import 'package:constellation_cafe/feature/auth/data/dto/response/current_user_response.dart';
import 'package:constellation_cafe/feature/auth/data/repository/jwt.dart';
import 'package:constellation_cafe/feature/auth/data/repository/login.dart';
import 'package:constellation_cafe/feature/auth/domain/method/login_method.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/auth/notifier/login_check_notifier.dart';
import 'package:constellation_cafe/feature/auth/state/login_status.dart';
import 'package:constellation_cafe/feature/guild_select/notifier/guild_state_notifier.dart';
import 'package:constellation_cafe/feature/module_config/data/api/module_config_api.dart';
import 'package:constellation_cafe/feature/module_config/data/repository/module_config_repository.dart';
import 'package:constellation_cafe/feature/module_config/data/repository/module_config_repository_provider.dart';
import 'package:constellation_cafe/feature/module_config/notifier/module_config_notifier.dart';
import 'package:constellation_cafe/feature/modules/academy/data/api/academy_api.dart';
import 'package:constellation_cafe/feature/modules/academy/notifier/permission_notifier/academy_permission_notifier.dart';
import 'package:constellation_cafe/feature/modules/competition/data/repository/competition_repository_provider.dart';
import 'package:constellation_cafe/feature/modules/competition/notifier/competition_permission_notifier.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/data/repository/penalty_repository_provider.dart';

import '../../../support/fake_backend.dart';
import '../../../support/feature/modules/competition/support/fake_competition_repository.dart';
import '../../../support/feature/modules/erp/penalty/support/fake_penalty_repository.dart';
import '../../../support/feature/auth/support/fake_auth_service.dart';

void main() {
  group('OAuthService 계약', () {
    late FakeBackend backend;

    setUp(() => backend = FakeBackend());
    tearDown(() => backend.close());

    test('me는 dio로 /auth/me를 조회하고 사용자 상태로 변환된다', () async {
      backend.reply('GET', '/auth/me', ok(meJson()));

      final response = await OAuthService(dio: backend.dio).me();
      final user = CurrentUserResponse.fromJson(response.response).toState();

      expect(backend.last.method, 'GET');
      expect(response.success, isTrue);
      expect(user.userId, '123');
      expect(user.roles, ['ROLE_ADMIN']);
      expect(user.avatarUrl, 'https://cdn.example.invalid/a.png');
    });

    test('check는 JSON을 요청하고 로그인 여부를 읽는다', () async {
      late http.Request captured;
      final client = MockClient((request) async {
        captured = request;
        return http.Response(
          jsonEncode(ok({'isLogin': true, 'roomSelected': false})),
          200,
        );
      });

      final response = await http.runWithClient(
        () => OAuthService(dio: backend.dio).check(),
        () => client,
      );

      expect(captured.method, 'GET');
      expect(captured.url.path, endsWith('/auth/check'));
      expect(captured.headers['Accept'], 'application/json');
      expect(response.response['isLogin'], isTrue);
    });

    test('refresh는 200일 때만 성공으로 본다', () async {
      final statuses = [200, 401];
      final client = MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.url.path, endsWith('/auth/refresh'));
        return http.Response('{}', statuses.removeAt(0));
      });

      final service = OAuthService(dio: backend.dio);
      final results = await http.runWithClient(
        () async => [await service.refresh(), await service.refresh()],
        () => client,
      );

      expect(results, [true, false]);
    });

    test('refresh 네트워크 오류는 예외 대신 실패로 처리한다', () async {
      final client = MockClient((_) async => throw http.ClientException('x'));

      final result = await http.runWithClient(
        () => OAuthService(dio: backend.dio).refresh(),
        () => client,
      );

      expect(result, isFalse);
    });

    test('logout은 /auth/logout에 POST한다', () async {
      final paths = <String>[];
      final client = MockClient((request) async {
        paths.add('${request.method} ${request.url.path}');
        return http.Response('{}', 200);
      });

      await http.runWithClient(
        () => OAuthService(dio: backend.dio).logout(),
        () => client,
      );

      expect(paths.single, endsWith('/auth/logout'));
      expect(paths.single, startsWith('POST'));
    });
  });

  test('Discord 인증 URI는 code 응답과 identify, guilds 범위를 요청한다', () {
    final uri = DiscordLogin().discordAuthUri;

    expect(uri.host, 'discord.com');
    expect(uri.path, '/oauth2/authorize');
    expect(uri.queryParameters['response_type'], 'code');
    expect(uri.queryParameters['scope'], 'identify+guilds');
    expect(LoginMethodType.discord.typeToString(), 'discord');
  });

  group('LoginCheckNotifier', () {
    late FakeAuthService auth;
    late FakeBackend backend;
    late ProviderContainer container;

    setUp(() {
      auth = FakeAuthService();
      backend = FakeBackend();
      backend.reply(
        'GET',
        '/api/bots/current/module-configs',
        ok([
          {'moduleId': 'chatbot', 'addOns': []},
          {
            'moduleId': 'network_operations',
            'addOns': ['academy', 'competition'],
          },
          {'moduleId': 'shadowverse', 'addOns': []},
        ]),
      );
      backend.reply(
        'GET',
        '/api/academy/me/permissions',
        ok({'admin': false, 'academies': []}),
      );
      container = ProviderContainer(
        overrides: [
          jwtApiProvider.overrideWithValue(Jwt(auth)),
          loginApiProvider.overrideWithValue(Login(auth)),
          academyApiProvider.overrideWithValue(AcademyApi(dio: backend.dio)),
          moduleConfigRepositoryProvider.overrideWithValue(
            ModuleConfigRepository(api: ModuleConfigApi(dio: backend.dio)),
          ),
          competitionRepositoryProvider.overrideWithValue(
            FakeCompetitionRepository(),
          ),
          penaltyRepositoryProvider.overrideWithValue(FakePenaltyRepository()),
        ],
      );
    });

    tearDown(() {
      container.dispose();
      backend.close();
    });

    /// 응답을 준비한 뒤에 provider를 구독해야 첫 확인에 그 응답이 쓰인다.
    Future<LoginStatus> checkLogin() {
      container.listen(loginCheckProvider, (_, _) {});
      return container.read(loginCheckProvider.future);
    }

    test('채팅방까지 선택된 토큰이면 사용자와 아카데미 권한을 불러온다', () async {
      auth.checks.add(checkResponse(isLogin: true, roomSelected: true));

      final status = await checkLogin();

      expect(status, const LoginStatus(isLoggedIn: true, roomSelected: true));
      expect(auth.meCalls, 1);
      expect(container.read(currentUserStateProvider).userId, '123');
      expect(container.read(academyPermissionProvider).isInitialized, isTrue);
      expect(backend.calls, [
        'GET /api/bots/current/module-configs',
        'GET /api/academy/me/permissions',
      ]);
      expect(
        container.read(competitionPermissionProvider).isInitialized,
        isTrue,
      );
    });

    test('refresh 힌트가 있으면 토큰을 갱신한 뒤 다시 확인한다', () async {
      auth.refreshResult = true;
      auth.checks.addAll([
        checkResponse(refreshHint: true),
        checkResponse(isLogin: true),
      ]);

      final status = await checkLogin();

      expect(status, const LoginStatus(isLoggedIn: true, roomSelected: false));
      expect(auth.refreshCalls, 1);
      expect(auth.checkCalls, 2);
      expect(auth.meCalls, 0, reason: '채팅방 선택 전에는 /auth/me를 부르지 않는다');
      expect(backend.calls, isEmpty, reason: '채팅방 선택 전에는 모듈·권한 API를 부르지 않는다');
    });

    test('401 응답에서 refresh가 실패하면 로그아웃 상태가 된다', () async {
      auth.checks.add(errorResponse(401));

      final status = await checkLogin();

      expect(status, LoginStatus.loggedOut);
      expect(auth.refreshCalls, 1);
    });

    test('인증 오류가 아닌 실패 응답은 refresh 없이 로그아웃 처리한다', () async {
      auth.checks.add(errorResponse(500));

      final status = await checkLogin();

      expect(status, LoginStatus.loggedOut);
      expect(auth.refreshCalls, 0);
    });

    test('로그아웃은 서버 세션 종료가 실패해도 사용자·채팅방 상태를 지운다', () async {
      auth.checks.add(checkResponse(isLogin: true, roomSelected: true));
      await checkLogin();
      container
          .read(currentGuildStateProvider.notifier)
          .setGuild(guildId: '1', guildName: '별자리', guildIcon: '');
      auth.logoutError = Exception('offline');

      await container.read(loginCheckProvider.notifier).logout();

      expect(container.read(loginCheckProvider).value, LoginStatus.loggedOut);
      expect(auth.logoutCalls, 1);
      expect(container.read(currentUserStateProvider).userId, isEmpty);
      expect(container.read(currentGuildStateProvider).guildId, isEmpty);
      expect(container.read(moduleConfigProvider).value?.isEmpty, isTrue);
    });

    test('강제 로그아웃 뒤 recheck는 서버를 다시 호출하지 않는다', () async {
      auth.checks.add(checkResponse(isLogin: true));
      await checkLogin();

      final notifier = container.read(loginCheckProvider.notifier);
      notifier.forceLogout();
      await notifier.recheck();

      expect(container.read(loginCheckProvider).value, LoginStatus.loggedOut);
      expect(auth.checkCalls, 1);
    });
  });
}
