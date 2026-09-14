import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../data/dto/response/lesson_record_query_response.dart';
import '../../domain/model/lesson_record.dart';
import '../../domain/model/lesson_record_list/lesson_record_list.dart';
import '../../domain/model/subject.dart';

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