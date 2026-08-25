import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/lesson_record_selection/lesson_record_selection.dart';


part 'lesson_record_selection_state.freezed.dart';

@freezed
abstract class LessonRecordSelectionState with _$LessonRecordSelectionState {
  const factory LessonRecordSelectionState({
    @Default(false) bool isLoading,
    @Default(LessonRecordSelection()) LessonRecordSelection queryForm,
    String? errorMessage,
  }) = _LessonRecordSelectionState;
}