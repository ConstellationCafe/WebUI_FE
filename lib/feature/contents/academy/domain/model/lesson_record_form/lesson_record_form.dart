import 'package:freezed_annotation/freezed_annotation.dart';

import '../academy.dart';
import '../academy_class.dart';
import '../subject.dart';
import '../teacher.dart';
import '../student.dart';

part 'lesson_record_form.freezed.dart';

@freezed
abstract class LessonRecordForm with _$LessonRecordForm {
  const factory LessonRecordForm({
    @Default([]) List<Academy> academies,
    @Default([]) List<AcademyClass> classes,
    @Default([]) List<Student> students,
    Academy? selectedAcademy,
    AcademyClass? selectedAcademyClass,
    Subject? selectedSubject,
    Teacher? mainTeacher,
    @Default([]) List<Teacher> selectedCoTeachers,
    @Default([]) List<Student> selectedStudents,
    DateTime? educationDate,
    DateTime? startTime,
    DateTime? endTime,
    @Default('') String description,
  }) = _LessonRecordForm;
}