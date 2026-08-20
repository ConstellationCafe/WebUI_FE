import 'package:freezed_annotation/freezed_annotation.dart';

import '../academy.dart';
import '../academy_class.dart';
import '../lesson_record.dart';
import '../subject.dart';
import '../teacher.dart';
import '../student.dart';

part 'lesson_record_form.freezed.dart';

@freezed
abstract class LessonRecordList with _$LessonRecordList {
  const factory LessonRecordList({
    Academy? selectedAcademy,
    AcademyClass? selectedAcademyClass,
    Subject? selectedSubject,
    DateTime? educationDate,
    DateTime? startTime,
    DateTime? endTime,
    List<LessonRecord> records,
  }) = _LessonRecordList;
}