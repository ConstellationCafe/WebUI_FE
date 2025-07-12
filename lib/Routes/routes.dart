import 'package:go_router/go_router.dart';

import '../Pages/HomePage.dart';

GoRouter routes = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => HomePage(),
    ),
  ],
);
