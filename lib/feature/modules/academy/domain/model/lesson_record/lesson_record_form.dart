import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_record_form.freezed.dart';

@freezed
abstract class LessonRecordForm with _$LessonRecordForm {
  const factory LessonRecordForm({@Default('') String description}) =
      _LessonRecordForm;
}
