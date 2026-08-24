import 'package:freezed_annotation/freezed_annotation.dart';

import '../academy.dart';
import '../academy_class.dart';
import '../student.dart';
import '../subject.dart';
import '../teacher.dart';

part 'lesson_record_query.freezed.dart';

@freezed
abstract class LessonRecordQuery with _$LessonRecordQuery {
  const factory LessonRecordQuery({
    @Default([]) List<Academy> academies,
    @Default([]) List<AcademyClass> classes,
    @Default([]) List<Teacher> teachers,
    @Default([]) List<Student> students,
    @Default([]) List<Subject> subjects,
    Academy? selectedAcademy,
    AcademyClass? selectedAcademyClass,
    Subject? selectedSubject,
    Teacher? mainTeacher,
    @Default([]) List<Teacher> selectedCoTeachers,
    @Default([]) List<Student> selectedStudents,
    DateTime? educationDate,
    DateTime? startTime,
    DateTime? endTime,
  }) = _LessonRecordQuery;
}

extension LessonRecordQueryValidation
on LessonRecordQuery {
  bool get isValid {
    if (selectedAcademy == null) return false;
    if (selectedAcademyClass == null) return false;
    if (selectedSubject == null) return false;
    if (educationDate == null) return false;
    if (startTime == null || endTime == null) return false;
    if (mainTeacher == null) return false;
    if (!endTime!.isAfter(startTime!)) return false;
    return true;
  }
}