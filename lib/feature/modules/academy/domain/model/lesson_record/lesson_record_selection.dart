import 'package:freezed_annotation/freezed_annotation.dart';

import '../academy.dart';
import '../academy_class.dart';
import '../student.dart';
import '../subject.dart';
import '../teacher.dart';
import 'lesson_time_range.dart';

part 'lesson_record_selection.freezed.dart';

@freezed
abstract class LessonRecordSelection with _$LessonRecordSelection {
  const factory LessonRecordSelection({
    @Default([]) List<Academy> academies,
    @Default([]) List<AcademyClass> classes,
    @Default([]) List<Teacher> teachers,
    @Default([]) List<Teacher> coTeachers,
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
  }) = _LessonRecordSelection;
}

extension LessonRecordSelectionValidation on LessonRecordSelection {
  bool get isValid {
    if (selectedAcademy == null) return false;
    if (selectedAcademyClass == null) return false;
    if (selectedSubject == null) return false;
    if (educationDate == null) return false;
    if (startTime == null || endTime == null) return false;
    if (mainTeacher == null) return false;
    // 종료가 시작보다 이르면 자정을 넘긴 수업으로 본다.
    if (!LessonTimeRange.isValid(startTime!, endTime!)) return false;
    return true;
  }
}
