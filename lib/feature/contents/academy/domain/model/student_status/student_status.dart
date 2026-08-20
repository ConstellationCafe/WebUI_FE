import 'package:freezed_annotation/freezed_annotation.dart';

import '../academy.dart';
import '../../../domain/model/academy_class.dart';
import '../../../domain/model/student.dart';
import '../../../domain/model/subject.dart';
import '../../../domain/type/student_status_type.dart';

@freezed
abstract class StudentStatus with _$StudentStatus {
  const factory StudentStatus({
    @Default([])
    List<Academy> academies,
    @Default([])
    List<AcademyClass> classes,
    @Default([])
    List<Student> students,
    @Default([])
    List<Subject> subjects,
    String? selectedAcademyId,
    String? selectedClassName,
    String? selectedStudentId,
    StudentStatusType? selectedStatusType,
    @Default([])
    List<String> selectedSubjectIds,
    @Default('')
    String reason,
  }) = _StudentStatus;
}