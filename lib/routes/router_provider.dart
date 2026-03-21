// flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
// auth
import 'package:constellation_cafe/feature/auth/login/pages/login.dart';
// home
import 'package:constellation_cafe/feature/home/pages/home_page.dart';
import 'package:constellation_cafe/feature/home/widgets/home_contents.dart';
// user
import 'package:constellation_cafe/feature/user/profile/pages/profile.dart';
// contents
import 'package:constellation_cafe/feature/contents/friendlymatch/pages/friendly_match.dart';
import 'package:constellation_cafe/feature/contents/learning/pages/learning_list.dart';
import 'package:constellation_cafe/feature/contents/menu/pages/menu_list.dart';
import 'package:constellation_cafe/feature/contents/music/pages/music_list.dart';
import 'package:constellation_cafe/feature/contents/content/pages/content_list.dart';

import 'login_check_notifier.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final loginCheck = ref.watch(loginCheckProvider);

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: "/login",
        pageBuilder: (context, state) => _noAnim(state, const LoginPage()),
      ),
      ShellRoute(
        pageBuilder: (context, state, child) => _noAnim(state, HomePage(child: child)),
        routes: [
          GoRoute(
            path: "/",
            pageBuilder: (context, state) => _noAnim(state, const HomeContent()),
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
        ],
      ),
    ],
    redirect: (context, state) {
      final loc = state.matchedLocation;
      final isAtLoginPage = loc == "/login";

      // 로딩 중에는 리다이렉트 유보
      if (loginCheck.isLoading) return null;

      final isLoggedIn = loginCheck.value ?? false;

      // 비로그인 상태면 /login으로 이동
      if (!isLoggedIn) {
        return isAtLoginPage ? null : "/login";
      }

      // 로그인 상태에서 /login 접근 시 홈으로 이동
      if (isAtLoginPage) {
        return "/";
      }

      return null;
    },
  );
}

/// 애니메이션 없는 페이지 전환 헬퍼
Page<void> _noAnim(GoRouterState state, Widget child) {
  return NoTransitionPage<void>(
    key: state.pageKey,
    child: child,
  );
}