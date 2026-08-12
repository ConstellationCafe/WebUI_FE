// flutter
import 'package:constellation_cafe/feature/user/profile/pages/view_point_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
// auth
import 'package:constellation_cafe/feature/auth/pages/login.dart';
// home
import 'package:constellation_cafe/feature/home/pages/home_page.dart';
import 'package:constellation_cafe/feature/home/widgets/home_contents.dart';
// user
import 'package:constellation_cafe/feature/user/profile/pages/profile.dart';
// contents
import 'package:constellation_cafe/feature/contents/friendly_match/pages/friendly_match.dart';
import 'package:constellation_cafe/feature/contents/learning/pages/learning_list.dart';
import 'package:constellation_cafe/feature/contents/menu/pages/menu_list.dart';
import 'package:constellation_cafe/feature/contents/music/pages/music_list.dart';
import 'package:constellation_cafe/feature/contents/content/pages/content_list.dart';

import 'package:constellation_cafe/shared/widgets/loading/PageLoading.dart';

import '../feature/auth/notifier/login_check_notifier.dart';
import '../feature/contents/academy/class_content_record/page/class_content_record.dart';
import '../feature/guild_select/page/guild_select.dart';

part 'router_provider.g.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

@riverpod
GoRouter router(Ref ref) {
  final loginCheck = ref.watch(loginCheckProvider);
  print("GoRouter");
  return GoRouter(
    initialLocation: '/',
    observers: [routeObserver],
    routes: [
      GoRoute(
        path: "/login",
        pageBuilder: (context, state) => _noAnim(state, const LoginPage()),
      ),
      GoRoute(
        path: "/select",
        pageBuilder: (context, state) => _noAnim(state, const GuildSelectPage()),
      ),
      ShellRoute(
        pageBuilder: (context, state, child) => _noAnim(state, HomePage(child: child)),
        routes: [
          GoRoute(
            path: "/home",
            // redirect: (context, state) async {
            //   final guildId = state.uri.queryParameters['guild_id'];
            //   if (guildId == null) {
            //     return "/select";
            //   }
            //   final isValid = await validateGuildId(guildId);
            //   if (!isValid) {
            //     return "/select";
            //   }
            //   return null; // 정상 진입
            // },
            pageBuilder: (context, state) => _noAnim(state, HomeContent()),
          ),
          GoRoute(
            path: "/profile",
            pageBuilder: (context, state) => _noAnim(state, const Profile()),
          ),
          GoRoute(
            path: "/friendly_match",
            pageBuilder: (context, state) => _noAnim(state, const FriendlyMatch()),
          ),
          GoRoute(
            path: "/learning",
            pageBuilder: (context, state) => _noAnim(state, const LearningList()),
          ),
          GoRoute(
            path: "/menu",
            pageBuilder: (context, state) => _noAnim(state, const MenuList()),
          ),
          GoRoute(
            path: "/music",
            pageBuilder: (context, state) => _noAnim(state, const MusicList()),
          ),
          GoRoute(
            path: "/content",
            pageBuilder: (context, state) => _noAnim(state, const ContentList()),
          ),
          GoRoute(
            path: "/point_log",
            pageBuilder: (context, state) => _noAnim(state, const ViewPointLog()),
          ),
          GoRoute(
            path: "/academy/lesson_record",
            pageBuilder: (context, state) => _noAnim(state, const LessonRecordPage()),
          ),
        ],
      ),
    ],
    onException: (context, state, router) {
      router.go('/');
    },
    redirect: (context, state) {
      if (loginCheck.isLoading) return null;
      final loc = state.matchedLocation;
      final isLoggedIn = loginCheck.value ?? false;
      print("current loc : $loc");
      switch (loc) {
        case "/":
          // 로그인 → /select
          // 비로그인 → /login
          return isLoggedIn ? "/select" : "/login";
        case "/login":
          // 로그인 → /select
          // 비로그인 → /login 유지
          return isLoggedIn ? "/select" : null;
        default:
          // 로그인 → 현재 경로 유지
          // 비로그인 → /login
          return isLoggedIn ? null : "/login";
      }
    }
  );
}

/// 애니메이션 없는 페이지 전환 헬퍼
Page<void> _noAnim(GoRouterState state, Widget child) {
  return NoTransitionPage<void>(
    key: state.pageKey,
    child: child,
  );
}