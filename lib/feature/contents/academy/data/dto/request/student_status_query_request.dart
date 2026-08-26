import '../../../domain/type/student_roster_status.dart';

class StudentStatusQueryRequest {
  final int? academyId;
  final int? classId;
  final String? studentId;
  final StudentRosterStatus? status;
  final int page;
  final int size;

  const StudentStatusQueryRequest({
    this.academyId,
    this.classId,
    this.studentId,
    this.status,
    this.page = 1,
    this.size = 20,
  });

  Map<String, dynamic> toJson() {
    return {
      if (academyId != null)
        'academyId': academyId,

      if (classId != null)
        'classId': classId,

      if (studentId != null &&
          studentId!.isNotEmpty)
        'studentId': studentId,

      if (status != null)
        'status': _statusToApiValue(
          status!,
        ),

      'page': page,
      'size': size,
    };
  }

  String _statusToApiValue(
      StudentRosterStatus status,
      ) {
    switch (status) {
      case StudentRosterStatus.enrolled:
        return 'ENROLLED';

      case StudentRosterStatus.graduation:
        return 'GRADUATED';

      case StudentRosterStatus.expulsion:
        return 'EXPELLED';

      case StudentRosterStatus.withdrawal:
        return 'WITHDRAWN';

      case StudentRosterStatus.retirement:
        return 'RETIRED';

      case StudentRosterStatus.disciplinary:
        return 'DISCIPLINARY';
    }
  }
}