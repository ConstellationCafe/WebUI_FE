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

import '../feature/auth/notifier/login_check_notifier.dart';
import '../feature/contents/chatbot/routes/chatbot_routes.dart';
import '../feature/guild_select/page/guild_select.dart';
import '../feature/guild_select/provider/guild_list_provider.dart';

part 'router_provider.g.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
RouteObserver<ModalRoute<void>>();

@riverpod
GoRouter router(Ref ref) {
  final refreshNotifier = ValueNotifier<int>(0);
  ref.listen(
    loginCheckProvider,
        (_, __) => refreshNotifier.value++,
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
    observers: [
      routeObserver,
    ],
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => noAnim(
          state,
          const PageLoading(),
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => noAnim(
          state,
          const LoginPage(),
        ),
      ),
      GoRoute(
        path: '/select',
        pageBuilder: (context, state) => noAnim(
          state,
          const GuildSelectPage(),
        ),
      ),
      GoRoute(
        path: '/loading',
        pageBuilder: (context, state) => noAnim(
          state,
          const PageLoading(),
        ),
      ),
      ShellRoute(
        pageBuilder: (context, state, child) => noAnim(
          state,
          HomeFrame(
            child: child,
          ),
        ),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => noAnim(
              state,
              HomeContent(),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => noAnim(
              state,
              const Profile(),
            ),
          ),
          GoRoute(
            path: '/point_log',
            pageBuilder: (context, state) => noAnim(
              state,
              const ViewPointLog(),
            ),
          ),
          GoRoute(
            path: '/friendly_match',
            pageBuilder: (context, state) => noAnim(
              state,
              const FriendlyMatch(),
            ),
          ),
          ...chatbotRoutes,
          ...academyRoutes,
        ],
      ),
    ],

    onException: (
        context,
        state,
        router,
        ) {
      router.go('/');
    },

    refreshListenable: refreshNotifier,

    redirect: (context, state) {
      final loginCheck =
      ref.read(loginCheckProvider);

      if (loginCheck.isLoading) {
        return null;
      }

      final isLoggedIn =
          loginCheck.value ?? false;

      final loc =
          state.matchedLocation;

      if (!isLoggedIn) {
        return loc == '/login'
            ? null
            : '/login';
      }

      if (loc == '/') {
        return '/select';
      }

      if (loc == '/login') {
        return '/select';
      }

      // /home 직접 접근
      if (loc == '/home') {
        final guildId =
        state.uri.queryParameters['guild_id'];

        if (guildId == null ||
            guildId.isEmpty) {
          return '/select';
        }

        final guildListAsync =
        ref.read(guildListProvider);

        // 아직 검증할 길드 목록이 없으면
        // ShellRoute 밖의 loading으로 이동
        if (guildListAsync.isLoading) {
          return Uri(
            path: '/loading',
            queryParameters: {
              'guild_id': guildId,
            },
          ).toString();
        }

        if (guildListAsync.hasError) {
          return '/select';
        }

        final guilds =
            guildListAsync.value ?? [];

        final isValidGuild =
        guilds.any(
              (guild) =>
          guild.id == guildId,
        );

        if (!isValidGuild) {
          return '/select';
        }

        return null;
      }

      // 길드 검증 대기 화면
      if (loc == '/loading') {
        final guildId =
        state.uri.queryParameters['guild_id'];

        if (guildId == null ||
            guildId.isEmpty) {
          return '/select';
        }

        final guildListAsync =
        ref.read(guildListProvider);

        // 아직 API 응답 전이면
        // ShellRoute 밖에서 PageLoading 유지
        if (guildListAsync.isLoading) {
          return null;
        }

        if (guildListAsync.hasError) {
          return '/select';
        }

        final guilds =
            guildListAsync.value ?? [];

        final isValidGuild =
        guilds.any(
              (guild) =>
          guild.id == guildId,
        );

        if (!isValidGuild) {
          return '/select';
        }

        // 검증 성공 후에만 ShellRoute 진입
        return Uri(
          path: '/home',
          queryParameters: {
            'guild_id': guildId,
          },
        ).toString();
      }

      return null;
    },
  );
}

/// 애니메이션 없는 페이지 전환 헬퍼
Page<void> noAnim(
    GoRouterState state,
    Widget child,
    ) {
  return NoTransitionPage<void>(
    key: state.pageKey,
    child: child,
  );
}