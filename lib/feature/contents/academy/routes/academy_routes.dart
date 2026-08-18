import 'package:go_router/go_router.dart';
import '../../../../router/no_aim_page.dart';
import '../write_lesson_record/page/class_content_record.dart';


final academyRoutes = <GoRoute>[
  GoRoute(
    path: '/academy/lesson_record',
    pageBuilder: (context, state) =>
        noAnim(state, const LessonRecordPage()),
  )
];