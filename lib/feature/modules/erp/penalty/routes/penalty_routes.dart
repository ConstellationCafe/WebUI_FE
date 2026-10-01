import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/router/no_aim_page.dart';

import '../pages/admin_penalty_page.dart';
import '../pages/my_penalty_page.dart';

final penaltyRoutes = <GoRoute>[
  GoRoute(
    path: '/penalties',
    pageBuilder: (context, state) => noAnim(state, const AdminPenaltyPage()),
  ),
  GoRoute(
    path: '/my-penalties',
    pageBuilder: (context, state) => noAnim(state, const MyPenaltyPage()),
  ),
];
