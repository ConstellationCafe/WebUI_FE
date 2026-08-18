enum StudentStatusType {
  graduation,
  expulsion,
  withdrawal,
}

class StudentStatusForm {
  final String academyId;
  final String className;
  final String studentId;

  final StudentStatusType statusType;

  /// 졸업인 경우에만 사용.
  /// 0개 이상 선택 가능.
  final List<String> subjectIds;

  final String reason;

  const StudentStatusForm({
    required this.academyId,
    required this.className,
    required this.studentId,
    required this.statusType,
    this.subjectIds = const [],
    this.reason = '',
  });
}