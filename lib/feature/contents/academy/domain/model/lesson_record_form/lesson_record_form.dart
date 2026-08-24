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
    @Default('') String description,
  }) = _LessonRecordForm;
}