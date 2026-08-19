import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/model/academy.dart';
import '../domain/model/academy_class.dart';
import '../domain/dto/response/lesson_record_response.dart';
import '../domain/model/subject.dart';

part 'lesson_record_list_state.freezed.dart';

@freezed
abstract class LessonRecordListState
    with _$LessonRecordListState {
  const factory LessonRecordListState({
    @Default(false)
    bool isLoading,

    @Default(false)
    bool isFilterLoading,

    @Default([])
    List<LessonRecordResponse> records,

    @Default([])
    List<Academy> academies,

    @Default([])
    List<AcademyClass> classes,

    @Default([])
    List<Subject> subjects,

    String? selectedAcademyId,

    String? selectedClassId,

    String? selectedSubjectId,

    DateTime? selectedDate,

    String? selectedTime,

    String? selectedTeacherId,

    String? errorMessage,
  }) = _LessonRecordListState;
}