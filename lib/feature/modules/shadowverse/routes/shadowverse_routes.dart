import 'package:go_router/go_router.dart';
import '../../../../router/no_aim_page.dart';
import '../friendly_match/pages/friendly_match.dart';

final shadowverseRoutes = <GoRoute>[
  GoRoute(
    path: '/friendly_match',
    pageBuilder: (context, state) => noAnim(state, const FriendlyMatch()),
  ),
];
