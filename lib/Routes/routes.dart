import 'package:constellation_cafe/Components/FunctionalComponents/FriendlyMatch/FriendlyMatch.dart';
import 'package:go_router/go_router.dart';

import '../Pages/HomePage/Contents/Contents.dart';
import '../Pages/HomePage/HomePage.dart';
import '../Pages/ProfilePage/ProfilePage.dart';

GoRouter routes = GoRouter(
  routes: [
    ShellRoute(
      builder: (build, state, child) {
        return HomePage(child: child);
      },
      routes: [
        GoRoute(
          path: "/",
          builder: (build, state) => HomeContent(),
          routes: [
            GoRoute(
              path: "/profile",
              builder: (build, state) => ProfilePage(),
            ),
            GoRoute(
              path: "friendly_match",
              builder: (build, state) => FriendlyMatch(),
            ),
          ],
        ),
      ],
    ),
  ],
);
