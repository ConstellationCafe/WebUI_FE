import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/lesson_record/lesson_record_list.dart';

part 'lesson_record_list_state.freezed.dart';

@freezed
abstract class LessonRecordListState with _$LessonRecordListState {
  const factory LessonRecordListState({
    @Default(false) bool isLoading,
    @Default(false) bool isFilterLoading,
    @Default(LessonRecordList()) LessonRecordList lessonRecordList,
    String? errorMessage,
  }) = _LessonRecordListState;
}
