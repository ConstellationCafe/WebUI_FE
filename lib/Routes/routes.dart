import 'package:go_router/go_router.dart';

import '../Pages/HomePage/Contents/Contents.dart';
import '../Pages/HomePage/HomePage.dart';
import '../Pages/ProfilePage/ProfilePage.dart';

GoRouter routes = GoRouter(
  routes: [
    // Shell Route를 사용해서 HomePage 레이아웃을 유지
    ShellRoute(
      builder: (context, state, child) {
        return HomePage(child: child);
      },
      routes: [
        GoRoute(
          path: "/",
          builder: (context, state) => HomeContent(), // 홈 페이지 메인 컨텐츠
        ),
        GoRoute(
          path: "/profile",
          builder: (context, state) => ProfilePage(),
        ),
      ],
    ),
  ],
);
