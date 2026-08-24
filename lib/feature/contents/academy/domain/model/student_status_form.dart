

import '../type/student_status_type.dart';

class StudentStatusForm {
  final String academyName;
  final String className;
  final String studentDiscordId;

  final StudentStatusType statusType;
  /// 졸업인 경우에만 사용.
  /// 0개 이상 선택 가능.
  final List<int> subjectIds;
  final String reason;

  const StudentStatusForm({
    required this.academyName,
    required this.className,
    required this.studentDiscordId,
    required this.statusType,
    this.subjectIds = const [],
    this.reason = '',
  });
}