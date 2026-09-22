import 'package:go_router/go_router.dart';
import '../../../../router/no_aim_page.dart';

import '../learning/pages/learning_list.dart';
import '../menu/pages/menu_list.dart';
import '../music/pages/music_list.dart';
import '../content/pages/content_list.dart';

final chatbotRoutes = <GoRoute>[
  GoRoute(
    path: '/learning',
    pageBuilder: (context, state) => noAnim(state, const LearningList()),
  ),
  GoRoute(
    path: '/menu',
    pageBuilder: (context, state) => noAnim(state, const MenuList()),
  ),
  GoRoute(
    path: '/music',
    pageBuilder: (context, state) => noAnim(state, const MusicList()),
  ),
  GoRoute(
    path: '/content',
    pageBuilder: (context, state) => noAnim(state, const ContentList()),
  ),
];
