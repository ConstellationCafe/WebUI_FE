import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/lesson_record_form/lesson_record_form.dart';

part 'lesson_record_form_state.freezed.dart';

@freezed
abstract class LessonRecordFormState with _$LessonRecordFormState {
  const factory LessonRecordFormState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(LessonRecordForm()) lessonRecordForm,
    String? errorMessage,
  }) = _LessonRecordFormState;
}