import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/router/no_aim_page.dart';

import '../pages/admin_notification_page.dart';

final notificationRoutes = <GoRoute>[
  GoRoute(
    path: '/notification',
    pageBuilder: (context, state) =>
        noAnim(state, const AdminNotificationPage()),
  ),
];
