import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/auth/service/jwt.dart';
import 'package:constellation_cafe/feature/auth/service/login.dart';
import 'package:constellation_cafe/feature/guild_select/notifier/guild_state_notifier.dart';
import 'package:constellation_cafe/feature/home/frame/pages/home_frame.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/main_menu_bar.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/profile/profile_menu.dart';
import 'package:constellation_cafe/feature/home/home_page/pages/home_contents.dart';
import 'package:constellation_cafe/feature/modules/academy/data/api/academy_api.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/academy_permission.dart';
import 'package:constellation_cafe/feature/modules/academy/notifier/permission_notifier/academy_permission_notifier.dart';
import 'package:constellation_cafe/feature/notification/notifier/notification_center_notifier.dart';
import 'package:constellation_cafe/shared/domain/user/user_role.dart';

import '../auth/support/fake_auth_service.dart';
import '../notification/support/fake_notification_repository.dart';

Widget page(String name) => Center(child: Text('$name page'));

Widget shell(bool frame, Widget child) {
  if (frame) return HomeFrame(child: child);
  final menu = Row(
    children: [
      const MainMenuBar(),
      Expanded(child: child),
    ],
  );
  return Scaffold(body: menu);
}

List<Map<String, dynamic>> academiesFor(String role) {
  if (role.isEmpty) return [];
  final classIds = [1];
  return [
    {'academyId': 1, 'role': role, 'classIds': classIds},
  ];
}

/// Dio 없이 권한을 돌려준다. 위젯 테스트의 가짜 시간에서 네트워크 타이머를
/// 기다리지 않도록 한다.
class FakeAcademyApi extends AcademyApi {
  FakeAcademyApi() : super(dio: Dio());

  AcademyPermission permission = AcademyPermission.initial();

  @override
  Future<AcademyPermission> getMyPermissions() async => permission;
}

class HomeHarness {
  HomeHarness({required bool frame}) {
    container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        jwtApiProvider.overrideWithValue(Jwt(auth)),
        loginApiProvider.overrideWithValue(Login(auth)),
        academyApiProvider.overrideWithValue(academyApi),
        notificationRepositoryProvider.overrideWithValue(notifications),
      ],
    );
    router = GoRouter(
      initialLocation: '/home',
      routes: [
        ShellRoute(
          builder: (_, _, child) => shell(frame, child),
          routes: [
            GoRoute(path: '/home', builder: (_, _) => const HomeContent()),
            GoRoute(path: '/learning', builder: (_, _) => page('learning')),
            GoRoute(path: '/point', builder: (_, _) => page('point')),
          ],
        ),
        GoRoute(path: '/login', builder: (_, _) => page('login')),
        GoRoute(path: '/profile', builder: (_, _) => page('profile')),
      ],
    );
  }

  final FakeAcademyApi academyApi = FakeAcademyApi();
  final FakeAuthService auth = FakeAuthService();
  final FakeNotificationRepository notifications = FakeNotificationRepository();
  late final ProviderContainer container;
  late final GoRouter router;

  Future<void> signIn({
    List<String> roles = const [],
    String academyRole = '',
  }) async {
    final user = container.read(currentUserStateProvider.notifier);
    user.update(userId: '123', globalName: '별', roles: roles);
    final guild = container.read(currentGuildStateProvider.notifier);
    guild.setGuild(guildId: '1', guildName: '별자리', guildIcon: '');
    final permission = {'admin': false, 'academies': academiesFor(academyRole)};
    academyApi.permission = AcademyPermission.fromJson(permission);
    await container.read(academyPermissionProvider.notifier).initialize();
  }

  Widget app() => UncontrolledProviderScope(
    container: container,
    child: MaterialApp.router(
      theme: CustomTheme.themeData,
      routerConfig: router,
    ),
  );

  void dispose() => container.dispose();
}

Future<HomeHarness> pumpHome(
  WidgetTester tester, {
  required Size size,
  bool frame = false,
  List<String> roles = const [],
  String academyRole = '',
}) async {
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  final harness = HomeHarness(frame: frame);
  addTearDown(harness.dispose);
  await harness.signIn(roles: roles, academyRole: academyRole);
  await tester.pumpWidget(harness.app());
  await tester.pumpAndSettle();
  return harness;
}

void main() {
  group('메뉴 바', () {
    testWidgets('일반 회원에게는 공통 메뉴만 보여준다', (tester) async {
      await pumpHome(tester, size: const Size(1400, 1000));

      expect(find.text('빗자루 메뉴'), findsOneWidget);
      expect(find.text('섀도우버스 메뉴'), findsOneWidget);
      expect(find.text('아카데미 메뉴'), findsNothing);
      expect(find.text('ERP 메뉴'), findsNothing);
      expect(find.text('홈페이지 메인 컨텐츠'), findsOneWidget);
    });

    testWidgets('관리자와 교사 권한이 있으면 ERP와 아카데미 메뉴를 추가한다', (tester) async {
      await pumpHome(
        tester,
        size: const Size(1400, 1200),
        roles: [UserRole.ADMIN],
        academyRole: 'TEACHER',
      );

      expect(find.text('아카데미 메뉴'), findsOneWidget);
      expect(find.text('수업 기록'), findsOneWidget);
      expect(find.text('교사 관리'), findsNothing, reason: '교사는 원장 메뉴를 보지 않는다');
      expect(find.text('ERP 메뉴'), findsOneWidget);
      expect(find.text('포인트 관리'), findsOneWidget);
    });

    testWidgets('메뉴를 누르면 해당 화면으로 이동한다', (tester) async {
      await pumpHome(tester, size: const Size(1400, 1000));

      await tester.tap(find.text('가르치기'));
      await tester.pumpAndSettle();

      expect(find.text('learning page'), findsOneWidget);
      expect(find.text('홈페이지 메인 컨텐츠'), findsNothing);
    });
  });

  group('모바일 홈 프레임', () {
    testWidgets('메뉴 버튼으로 drawer를 열고 메뉴를 고르면 닫힌다', (tester) async {
      await pumpHome(tester, size: const Size(390, 844), frame: true);

      expect(find.text('별자리'), findsOneWidget);
      expect(find.text('빗자루 메뉴'), findsNothing);

      await tester.tap(find.byTooltip('Menu'));
      await tester.pumpAndSettle();
      expect(find.text('빗자루 메뉴'), findsOneWidget);

      await tester.tap(find.text('가르치기'));
      await tester.pumpAndSettle();
      expect(find.text('learning page'), findsOneWidget);
      expect(find.byType(Drawer), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('프로필 메뉴에서 로그아웃하면 상태를 비우고 로그인으로 이동한다', (tester) async {
      final harness = await pumpHome(
        tester,
        size: const Size(390, 844),
        frame: true,
      );
      harness.auth.checks.add(checkResponse(isLogin: true));

      await tester.tap(find.byType(ProfileMenu));
      await tester.pumpAndSettle();
      expect(find.text('프로필 수정'), findsOneWidget);
      expect(find.text('내 벌점'), findsOneWidget);

      await tester.tap(find.text('로그아웃'));
      await tester.pumpAndSettle();

      final container = harness.container;
      expect(harness.auth.logoutCalls, 1);
      expect(container.read(currentUserStateProvider).userId, isEmpty);
      expect(container.read(currentGuildStateProvider).guildId, isEmpty);
      expect(find.text('login page'), findsOneWidget);
    });
  });
}
