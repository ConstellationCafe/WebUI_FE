import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/status_query/status_query.dart';
import '../../domain/model/teacher.dart';
import '../../domain/model/teacher_status_list/teacher_status_list.dart';
import '../../domain/type/teacher_roster_status.dart';

part 'teacher_status_list_state.freezed.dart';

@freezed
abstract class TeacherStatusListState
    with _$TeacherStatusListState {
  const factory TeacherStatusListState({
    @Default(false)
    bool isLoading,

    @Default(false)
    bool isFilterLoading,

    @Default(
      StatusQuery<Teacher, TeacherRosterStatus>(),
    )
    StatusQuery<Teacher, TeacherRosterStatus> query,

    @Default(TeacherStatusList())
    TeacherStatusList teacherStatusList,

    String? errorMessage,
  }) = _TeacherStatusListState;
}