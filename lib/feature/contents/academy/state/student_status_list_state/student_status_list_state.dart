import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/student_status_list/student_status_list.dart';
import '../../domain/model/student_status_query/student_status_query.dart';

part 'student_status_list_state.freezed.dart';

@freezed
abstract class StudentStatusListState with _$StudentStatusListState {
  const factory StudentStatusListState({
    @Default(false) bool isLoading,
    @Default(false) bool isFilterLoading,

    @Default(StudentStatusQuery())
    StudentStatusQuery query,

    @Default(StudentStatusList())
    StudentStatusList studentStatusList,

    String? errorMessage,
  }) = _StudentStatusListState;
}