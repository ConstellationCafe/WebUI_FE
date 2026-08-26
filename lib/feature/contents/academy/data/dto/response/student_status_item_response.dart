import '../../../domain/model/academy.dart';
import '../../../domain/model/academy_class.dart';
import '../../../domain/model/student.dart';
import '../../../domain/type/student_roster_status.dart';

class StudentStatusItemResponse {
  final Student student;
  final Academy academy;
  final AcademyClass academyClass;
  final StudentRosterStatus status;
  final DateTime? statusChangedAt;
  final String? reason;

  const StudentStatusItemResponse({
    required this.student,
    required this.academy,
    required this.academyClass,
    required this.status,
    required this.statusChangedAt,
    required this.reason,
  });

  factory StudentStatusItemResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return StudentStatusItemResponse(
      student: Student.fromJson(
        json['student'] as Map<String, dynamic>,
      ),
      academy: Academy.fromJson(
        json['academy'] as Map<String, dynamic>,
      ),
      academyClass: AcademyClass.fromJson(
        json['academyClass']
        as Map<String, dynamic>,
      ),
      status: _statusFromJson(
        json['status'] as String,
      ),
      statusChangedAt:
      json['statusChangedAt'] == null
          ? null
          : DateTime.parse(
        json['statusChangedAt'] as String,
      ),
      reason: json['reason'] as String?,
    );
  }

  static StudentRosterStatus _statusFromJson(
      String value,
      ) {
    switch (value) {
      case 'ENROLLED':
        return StudentRosterStatus.enrolled;

      case 'GRADUATED':
        return StudentRosterStatus.graduation;

      case 'EXPELLED':
        return StudentRosterStatus.expulsion;

      case 'WITHDRAWN':
        return StudentRosterStatus.withdrawal;

      case 'RETIRED':
        return StudentRosterStatus.retirement;

      case 'DISCIPLINARY':
        return StudentRosterStatus.disciplinary;

      default:
        throw ArgumentError(
          '지원하지 않는 학생 상태입니다: $value',
        );
    }
  }
}