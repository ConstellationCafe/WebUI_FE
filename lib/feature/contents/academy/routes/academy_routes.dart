import 'package:constellation_cafe/feature/contents/academy/page/student_status/student_status_page.dart';
import 'package:go_router/go_router.dart';
import '../../../../router/no_aim_page.dart';
import '../page/read_lesson_record/lesson_record_list.dart';
import '../page/write_lesson_record/class_content_record.dart';


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
  ),
  GoRoute(
    path: '/academy/student_status',
    pageBuilder: (context, state) =>
        noAnim(state, const StudentStatusPage()),
  )
];