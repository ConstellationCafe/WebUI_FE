import '../page/edit_student_status/student_status_page.dart';
import 'package:go_router/go_router.dart';
import '../../../../router/no_aim_page.dart';
import '../page/read_lesson_record/lesson_record_list.dart';
import '../page/read_student_status/read_student_status.dart';
import '../page/edit_teacher_status/teacher_status_page.dart';
import '../page/read_teacher_status/read_teacher_status.dart';
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
  ),
  GoRoute(
    path: '/academy/teacher_status',
    pageBuilder: (context, state) =>
        noAnim(state, const TeacherStatusPage()),
  ),
  GoRoute(
    path: '/academy/read_student_status',
    pageBuilder: (context, state) =>
        noAnim(state, const ReadStudentStatusPage()),
  ),
  GoRoute(
    path: '/academy/read_teacher_status',
    pageBuilder: (context, state) =>
        noAnim(state, const ReadTeacherStatusPage()),
  )
];