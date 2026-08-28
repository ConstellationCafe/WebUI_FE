import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/status_query/status_query.dart';
import '../../domain/model/student.dart';
import '../../domain/model/student_status_list/student_status_list.dart';
import '../../domain/type/student_roster_status.dart';

part 'student_status_list_state.freezed.dart';

@freezed
abstract class StudentStatusListState
    with _$StudentStatusListState {
  const factory StudentStatusListState({
    @Default(false)
    bool isLoading,

    @Default(false)
    bool isFilterLoading,

    @Default(
      StatusQuery<Student, StudentRosterStatus>(),
    )
    StatusQuery<Student, StudentRosterStatus> query,

    @Default(StudentStatusList())
    StudentStatusList studentStatusList,

    String? errorMessage,
  }) = _StudentStatusListState;
}