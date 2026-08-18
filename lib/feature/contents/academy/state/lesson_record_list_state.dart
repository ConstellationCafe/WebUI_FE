import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/model/lesson_record_summary.dart';

part 'lesson_record_list_state.freezed.dart';


@freezed
abstract class LessonRecordListState with _$LessonRecordListState {
  const factory LessonRecordListState({
    @Default(false) bool isLoading,
    @Default([]) List<LessonRecordSummary> records,

    DateTime? selectedDate,
    String? selectedTime,
    String? selectedSubject,
    String? selectedTeacherId,
    String? errorMessage,
  }) = _LessonRecordListState;
}