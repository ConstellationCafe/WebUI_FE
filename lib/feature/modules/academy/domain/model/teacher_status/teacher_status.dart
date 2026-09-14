import 'package:freezed_annotation/freezed_annotation.dart';

import '../academy.dart';
import '../../../domain/model/academy_class.dart';
import '../../../domain/model/teacher.dart';
import '../../../domain/type/teacher_status_type.dart';

part 'teacher_status.freezed.dart';

@freezed
abstract class TeacherStatus with _$TeacherStatus {
  const factory TeacherStatus({
    @Default([]) List<Academy> academies,
    @Default([]) List<AcademyClass> classes,
    @Default([]) List<Teacher> teachers,
    Academy? selectedAcademy,
    AcademyClass? selectedAcademyClass,
    Teacher? selectedTeacher,
    TeacherStatusType? selectedStatusType,
    @Default('') String reason,k
  }) = _TeacherStatus;
}

extension TeacherStatusValidation
on TeacherStatus {
  bool get isValid {
    if (selectedAcademy == null) {
      return false;
    }
    if (selectedAcademyClass == null) {
      return false;
    }
    if (selectedTeacher == null) {
      return false;
    }
    if (selectedStatusType == null) {
      return false;
    }
    return true;
  }
}