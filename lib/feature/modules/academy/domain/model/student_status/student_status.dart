import 'package:freezed_annotation/freezed_annotation.dart';

import '../academy.dart';
import '../../../domain/model/academy_class.dart';
import '../../../domain/model/student.dart';
import '../../../domain/model/subject.dart';
import '../../../domain/type/student_status_type.dart';

part 'student_status.freezed.dart';

@freezed
abstract class StudentStatus with _$StudentStatus {
  const factory StudentStatus({
    @Default([]) List<Academy> academies,
    @Default([]) List<AcademyClass> classes,
    @Default([]) List<Student> students,
    @Default([]) List<Subject> subjects,
    Academy? selectedAcademy,
    AcademyClass? selectedAcademyClass,
    Student? selectedStudent,
    StudentStatusType? selectedStatusType,
    @Default([]) List<Subject> selectedSubjects,
    @Default('') String reason,
  }) = _StudentStatus;
}

extension StudentStatusValidation
on StudentStatus {
  bool get isValid {
    if (selectedAcademy == null) {
      return false;
    }
    if (selectedAcademyClass == null) {
      return false;
    }
    if (selectedStudent == null) {
      return false;
    }
    if (selectedStatusType == null) {
      return false;
    }
    return true;
  }
}