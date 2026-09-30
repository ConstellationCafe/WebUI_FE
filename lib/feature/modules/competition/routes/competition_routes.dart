import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/router/no_aim_page.dart';

import '../pages/admin_competition_page.dart';

final competitionRoutes = <GoRoute>[
  GoRoute(
    path: '/competitions',
    pageBuilder: (context, state) =>
        noAnim(state, const AdminCompetitionPage()),
  ),
];
