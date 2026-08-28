// flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/shared/widgets/loading/PageLoading.dart';

// auth
import 'package:constellation_cafe/feature/auth/pages/login.dart';

// home
import 'package:constellation_cafe/feature/home/frame/pages/home_frame.dart';
import 'package:constellation_cafe/feature/home/home_page/pages/home_contents.dart';

// user
import 'package:constellation_cafe/feature/profile/pages/profile.dart';
import 'package:constellation_cafe/feature/profile/pages/view_point_log.dart';

// contents
import 'package:constellation_cafe/feature/contents/friendly_match/pages/friendly_match.dart';
import 'package:constellation_cafe/feature/contents/academy/routes/academy_routes.dart';

import '../feature/auth/notifier/login_check_notifier.dart';
import '../feature/contents/chatbot/routes/chatbot_routes.dart';
import '../feature/guild_select/page/guild_select.dart';
import '../feature/guild_select/provider/guild_list_provider.dart';
import 'no_aim_page.dart';

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

      // ShellRoute 밖에 위치
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
      final loc = state.matchedLocation;

      final loginCheck =
      ref.read(loginCheckProvider);

      /*
       * /home 직접 접근인데
       * 로그인 상태 확인조차 끝나지 않았다면
       * 절대로 ShellRoute에 진입시키지 않는다.
       */
      if (loginCheck.isLoading) {
        if (loc == '/home') {
          final guildId =
          state.uri.queryParameters['guild_id'];

          return Uri(
            path: '/loading',
            queryParameters: {
              if (guildId != null)
                'guild_id': guildId,
            },
          ).toString();
        }

        // 이미 /loading이면 그대로 대기
        if (loc == '/loading') {
          return null;
        }

        return null;
      }

      final isLoggedIn =
          loginCheck.value ?? false;

      /*
       * 로그인하지 않은 경우
       */
      if (!isLoggedIn) {
        return loc == '/login'
            ? null
            : '/login';
      }

      /*
       * 로그인 완료 후 기본 경로 처리
       */
      if (loc == '/') {
        return '/select';
      }

      if (loc == '/login') {
        return '/select';
      }

      /*
       * /home 진입
       */
      if (loc == '/home') {
        final guildId =
        state.uri.queryParameters['guild_id'];

        // guild_id 자체가 없음
        if (guildId == null ||
            guildId.isEmpty) {
          return '/select';
        }

        final guildListAsync =
        ref.read(guildListProvider);

        /*
         * 길드 목록이 아직 준비되지 않았다면
         * ShellRoute 밖의 /loading으로 이동
         */
        if (guildListAsync.isLoading) {
          return Uri(
            path: '/loading',
            queryParameters: {
              'guild_id': guildId,
            },
          ).toString();
        }

        // 길드 목록 API 실패
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

        // 목록에 없는 길드
        if (!isValidGuild) {
          return '/select';
        }

        // 로그인 완료 + 길드 목록 완료 + 유효한 길드
        // 이때만 HomeFrame 진입 허용
        return null;
      }

      /*
       * /home 검증 대기용 /loading
       */
      if (loc == '/loading') {
        final guildId =
        state.uri.queryParameters['guild_id'];

        // guild_id 없이 /loading 직접 접근
        if (guildId == null ||
            guildId.isEmpty) {
          return '/select';
        }

        final guildListAsync =
        ref.read(guildListProvider);

        /*
         * 길드 목록 API가 아직 끝나지 않았으면
         * PageLoading 유지
         */
        if (guildListAsync.isLoading) {
          return null;
        }

        // 길드 목록 API 실패
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

        /*
         * 없는 guild_id
         */
        if (!isValidGuild) {
          return '/select';
        }

        /*
         * 검증 완료 + 정상 guild_id
         * 이제서야 /home 진입
         */
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