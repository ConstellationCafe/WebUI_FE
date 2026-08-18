import 'package:go_router/go_router.dart';
import '../../../../router/no_aim_page.dart';
import '../read_lesson_record/pages/lesson_record_list.dart';
import '../write_lesson_record/page/class_content_record.dart';


final academyRoutes = <GoRoute>[
  GoRoute(
    path: '/academy/write_lesson_record',
    pageBuilder: (context, state) =>
        noAnim(state, const LessonRecordPage()),
  ),
  GoRoute(
    path: '/academy/read_lesson_record',
    pageBuilder: (context, state) =>
        noAnim(state, const LessonRecordListPage()),
  )
];