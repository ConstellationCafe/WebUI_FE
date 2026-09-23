import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/feature/modules/erp/point/pages/point_management_page.dart';
import 'package:constellation_cafe/router/no_aim_page.dart';

final erpRoutes = <GoRoute>[
  GoRoute(
    path: '/point',
    pageBuilder: (context, state) =>
        noAnim(state, const PointManagementPage()),
  ),
];
