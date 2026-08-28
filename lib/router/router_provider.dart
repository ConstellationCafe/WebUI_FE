// flutter
import 'package:constellation_cafe/feature/contents/academy/routes/academy_routes.dart';
import 'package:constellation_cafe/feature/profile/pages/view_point_log.dart';
import 'package:constellation_cafe/shared/widgets/loading/PageLoading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
// auth
import 'package:constellation_cafe/feature/auth/pages/login.dart';
// home
import 'package:constellation_cafe/feature/home/frame/pages/home_frame.dart';
import 'package:constellation_cafe/feature/home/home_page/pages/home_contents.dart';
// user
import 'package:constellation_cafe/feature/profile/pages/profile.dart';
// contents
import 'package:constellation_cafe/feature/contents/friendly_match/pages/friendly_match.dart';
import 'package:constellation_cafe/feature/contents/learning/pages/learning_list.dart';
import 'package:constellation_cafe/feature/contents/menu/pages/menu_list.dart';
import 'package:constellation_cafe/feature/contents/music/pages/music_list.dart';
import 'package:constellation_cafe/feature/contents/content/pages/content_list.dart';
import '../feature/auth/notifier/login_check_notifier.dart';
import '../feature/guild_select/page/guild_select.dart';

import 'package:constellation_cafe/feature/guild_select/provider/guild_list_provider.dart';

part 'router_provider.g.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
  RouteObserver<ModalRoute<void>>();

@riverpod
GoRouter router(Ref ref) {
  // 로그인 상태 변경 시 redirect를 다시 실행하기 위한 notifier
  final refreshNotifier = ValueNotifier<int>(0);
  ref.listen(
    loginCheckProvider,
    (_, __) => refreshNotifier.value++
  );
  ref.listen(
    guildListProvider,
        (_, __) => refreshNotifier.value++,
  );
  ref.onDispose(() {
    refreshNotifier.dispose();
  });

  return GoRouter(
    initialLocation: '/',
    observers: [routeObserver],
    routes: [
      // 무한 루프 문제 때문에 "/"은 명시적으로 라우트 만듦
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => _noAnim(state, const PageLoading()),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => _noAnim(state, const LoginPage()),
      ),
      GoRoute(
        path: '/select',
        pageBuilder: (context, state) => _noAnim(state, const GuildSelectPage()),
      ),
      ShellRoute(
        pageBuilder: (context, state, child) => _noAnim(state, HomeFrame(child: child)),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) =>
                _noAnim(state, HomeContent()),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) =>
                _noAnim(state, const Profile()),
          ),
          GoRoute(
            path: '/friendly_match',
            pageBuilder: (context, state) =>
                _noAnim(state, const FriendlyMatch()),
          ),
          GoRoute(
            path: '/learning',
            pageBuilder: (context, state) =>
                _noAnim(state, const LearningList()),
          ),
          GoRoute(
            path: '/menu',
            pageBuilder: (context, state) =>
                _noAnim(state, const MenuList()),
          ),
          GoRoute(
            path: '/music',
            pageBuilder: (context, state) =>
                _noAnim(state, const MusicList()),
          ),
          GoRoute(
            path: '/content',
            pageBuilder: (context, state) =>
                _noAnim(state, const ContentList()),
          ),
          GoRoute(
            path: '/point_log',
            pageBuilder: (context, state) =>
                _noAnim(state, const ViewPointLog()),
          ),
          ...academyRoutes,
        ],
      ),
    ],
    // 존재하지 않는 경로
    onException: (context, state, router) {
      router.go('/');
    },
    // 로그인 상태 변경 시 GoRouter를 재생성하지 않고
    // redirect만 다시 실행
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final loginCheck = ref.read(loginCheckProvider);

      if (loginCheck.isLoading) {
        return null;
      }

      final isLoggedIn = loginCheck.value ?? false;
      final loc = state.matchedLocation;

      if (!isLoggedIn) {
        return loc == '/login' ? null : '/login';
      }

      if (loc == '/login') {
        return '/select';
      }

      // /home 길드 ID 유효성 검사
      if (loc == '/home') {
        final guildId =
        state.uri.queryParameters['guild_id'];

        if (guildId == null || guildId.isEmpty) {
          return '/select';
        }

        final guildListAsync =
        ref.read(guildListProvider);

        // 길드 목록을 아직 불러오는 중이면
        // PageLoading이 있는 "/"로 이동
        if (guildListAsync.isLoading) {
          return '/?guild_id=$guildId';
        }

        if (guildListAsync.hasError) {
          return '/select';
        }

        final guilds =
            guildListAsync.value ?? [];

        final isValidGuild = guilds.any(
              (guild) => guild.id == guildId,
        );

        if (!isValidGuild) {
          return '/select';
        }

        return null;
      }

      // 길드 검증을 위해 "/"에서 대기 중인 경우
      if (loc == '/') {
        final guildId =
        state.uri.queryParameters['guild_id'];

        // 일반적인 최초 "/" 접근
        if (guildId == null || guildId.isEmpty) {
          return '/select';
        }

        final guildListAsync =
        ref.read(guildListProvider);

        // 아직 검증 중이면 PageLoading 유지
        if (guildListAsync.isLoading) {
          return null;
        }

        // 길드 목록 조회 실패
        if (guildListAsync.hasError) {
          return '/select';
        }

        final guilds =
            guildListAsync.value ?? [];

        final isValidGuild = guilds.any(
              (guild) => guild.id == guildId,
        );

        // 존재하지 않는 길드
        if (!isValidGuild) {
          return '/select';
        }

        // 유효한 길드
        return '/home?guild_id=$guildId';
      }

      return null;
    },
  );
}

/// 애니메이션 없는 페이지 전환 헬퍼
Page<void> _noAnim(
    GoRouterState state,
    Widget child,
    ) {
  return NoTransitionPage<void>(
    key: state.pageKey,
    child: child,
  );
}