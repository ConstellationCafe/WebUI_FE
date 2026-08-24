import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/lesson_record_query/lesson_record_query.dart';


part 'lesson_record_query_state.freezed.dart';

@freezed
abstract class LessonRecordQueryState with _$LessonRecordQueryState {
  const factory LessonRecordQueryState({
    @Default(false) bool isLoading,
    @Default(LessonRecordQuery()) LessonRecordQuery queryForm,
    String? errorMessage,
  }) = _LessonRecordQueryState;
}