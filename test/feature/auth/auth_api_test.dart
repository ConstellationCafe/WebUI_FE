import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:constellation_cafe/feature/auth/api/discord_login.dart';
import 'package:constellation_cafe/feature/auth/api/oauth_service.dart';
import 'package:constellation_cafe/feature/auth/domain/method/login_method.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/auth/notifier/login_check_notifier.dart';
import 'package:constellation_cafe/feature/auth/service/jwt.dart';
import 'package:constellation_cafe/feature/auth/service/login.dart';
import 'package:constellation_cafe/feature/auth/state/current_user_state.dart';
import 'package:constellation_cafe/feature/auth/state/login_status.dart';
import 'package:constellation_cafe/feature/modules/academy/data/api/academy_api.dart';
import 'package:constellation_cafe/feature/modules/academy/notifier/permission_notifier/academy_permission_notifier.dart';

import '../../support/fake_backend.dart';
import 'support/fake_auth_service.dart';

void main() {
  group('OAuthService 계약', () {
    late FakeBackend backend;

    setUp(() => backend = FakeBackend());
    tearDown(() => backend.close());

    test('me는 dio로 /auth/me를 조회하고 사용자 상태로 변환된다', () async {
      backend.reply('GET', '/auth/me', ok(meJson()));

      final response = await OAuthService(dio: backend.dio).me();
      final user = CurrentUserState.fromJson(response.response);

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
        '/api/academy/me/permissions',
        ok({'admin': false, 'academies': []}),
      );
      container = ProviderContainer(
        overrides: [
          jwtApiProvider.overrideWithValue(Jwt(auth)),
          loginApiProvider.overrideWithValue(Login(auth)),
          academyApiProvider.overrideWithValue(AcademyApi(dio: backend.dio)),
        ],
      );
      container.listen(loginCheckProvider, (_, _) {});
    });

    tearDown(() {
      container.dispose();
      backend.close();
    });

    test('채팅방까지 선택된 토큰이면 사용자와 아카데미 권한을 불러온다', () async {
      auth.checks.add(checkResponse(isLogin: true, roomSelected: true));

      final status = await container.read(loginCheckProvider.future);

      expect(status, const LoginStatus(isLoggedIn: true, roomSelected: true));
      expect(auth.meCalls, 1);
      expect(container.read(currentUserStateProvider).userId, '123');
      expect(container.read(academyPermissionProvider).isInitialized, isTrue);
    });

    test('refresh 힌트가 있으면 토큰을 갱신한 뒤 다시 확인한다', () async {
      auth.refreshResult = true;
      auth.checks.addAll([
        checkResponse(refreshHint: true),
        checkResponse(isLogin: true),
      ]);

      final status = await container.read(loginCheckProvider.future);

      expect(status, const LoginStatus(isLoggedIn: true, roomSelected: false));
      expect(auth.refreshCalls, 1);
      expect(auth.checkCalls, 2);
      expect(auth.meCalls, 0, reason: '채팅방 선택 전에는 /auth/me를 부르지 않는다');
    });

    test('401 응답에서 refresh가 실패하면 로그아웃 상태가 된다', () async {
      auth.checks.add(errorResponse(401));

      final status = await container.read(loginCheckProvider.future);

      expect(status, LoginStatus.loggedOut);
      expect(auth.refreshCalls, 1);
    });

    test('인증 오류가 아닌 실패 응답은 refresh 없이 로그아웃 처리한다', () async {
      auth.checks.add(errorResponse(500));

      final status = await container.read(loginCheckProvider.future);

      expect(status, LoginStatus.loggedOut);
      expect(auth.refreshCalls, 0);
    });

    test('강제 로그아웃 뒤 recheck는 서버를 다시 호출하지 않는다', () async {
      auth.checks.add(checkResponse(isLogin: true));
      await container.read(loginCheckProvider.future);

      final notifier = container.read(loginCheckProvider.notifier);
      notifier.forceLogout();
      await notifier.recheck();

      expect(container.read(loginCheckProvider).value, LoginStatus.loggedOut);
      expect(auth.checkCalls, 1);
    });
  });
}
