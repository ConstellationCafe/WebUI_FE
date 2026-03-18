// flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// auth
import 'package:constellation_cafe/feature/auth/login/pages/login.dart';
// home
import 'package:constellation_cafe/feature/home/pages/HomePage.dart';
import 'package:constellation_cafe/feature/home/widgets/HomeContents.dart';
// user
import 'package:constellation_cafe/feature/user/profile/pages/Profile.dart';
// contents
import 'package:constellation_cafe/feature/contents/friendlymatch/pages/FriendlyMatch.dart';
import 'package:constellation_cafe/feature/contents/learning/pages/LearingList.dart';
import 'package:constellation_cafe/feature/contents/menu/pages/MenuList.dart';
import 'package:constellation_cafe/feature/contents/music/pages/MusicList.dart';
import 'package:constellation_cafe/feature/contents/content/pages/ContentList.dart';
// loginCheck
import 'package:constellation_cafe/routes/LoginCheckProvider.dart';

Page<void> noAnim(GoRouterState state, Widget child) {
  return NoTransitionPage<void>(
    key: state.pageKey,
    child: child,
  );
}

final routerProvider = Provider<GoRouter>((ref) {
  final loginCheck = ref.watch(loginCheckProvider);
  return GoRouter(
    routes: [
      GoRoute(
        path: "/login",
        pageBuilder: (context, state) => noAnim(state, LoginPage()),
      ),
      ShellRoute(
        pageBuilder: (context, state, child) =>
            noAnim(state, HomePage(child: child)),
        routes: [
          GoRoute(
            path: "/",
            pageBuilder: (context, state) =>
                noAnim(state, HomeContent()),
          ),
          GoRoute(
            path: "/profile",
            pageBuilder: (context, state) =>
                noAnim(state, Profile()),
          ),
          GoRoute(
            path: "/friendly_match",
            pageBuilder: (context, state) =>
                noAnim(state, FriendlyMatch()),
          ),
          GoRoute(
            path: "/learning",
            pageBuilder: (context, state) =>
                noAnim(state, LearningList()),
          ),
          GoRoute(
            path: "/menu",
            pageBuilder: (context, state) =>
                noAnim(state, MenuList()),
          ),
          GoRoute(
            path: "/music",
            pageBuilder: (context, state) =>
                noAnim(state, MusicList()),
          ),
          GoRoute(
            path: "/content",
            pageBuilder: (context, state) =>
                noAnim(state, ContentList()),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      /** return null 은 아무것도 하지 않는다는 의미 */
      final loc = state.matchedLocation;
      final isLogin = loc == "/login";

      // 로딩 상태면 현재 페이지 유지
      if (loginCheck.isLoading) return null;
      // 로딩 완료 후
      final isLoggedIn = loginCheck.value ?? false;
      if (!isLoggedIn) return isLogin ? null : "/login";
      // 로그인 된 상태에서 현재 경로가 /login 면 /으로 강제 이동
      if (isLogin) return "/";
      return null;
    },
  );
});