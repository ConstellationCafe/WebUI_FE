import '../type/teacher_status_type.dart';


class TeacherStatusForm {
  final String academyName;
  final String className;
  final String teacherDiscordId;

  final TeacherStatusType statusType;
  final String reason;

  const TeacherStatusForm({
    required this.academyName,
    required this.className,
    required this.teacherDiscordId,
    required this.statusType,
    this.reason = '',
  });
}