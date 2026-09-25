import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/router/no_aim_page.dart';

import '../pages/admin_point_page.dart';

final pointRoutes = <GoRoute>[
  GoRoute(
    path: '/point',
    pageBuilder: (context, state) => noAnim(state, const AdminPointPage()),
  ),
];
