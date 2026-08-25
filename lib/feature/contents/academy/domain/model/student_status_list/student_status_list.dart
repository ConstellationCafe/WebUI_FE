import 'package:freezed_annotation/freezed_annotation.dart';

import '../student_status_view/student_status_view.dart';

part 'student_status_list.freezed.dart';

@freezed
abstract class StudentStatusList with _$StudentStatusList {
  const factory StudentStatusList({
    @Default([]) List<StudentStatusView> items,

    @Default(0) int totalCount,
    @Default(0) int enrolledCount,
    @Default(0) int graduationCount,
    @Default(0) int expulsionCount,
    @Default(0) int withdrawalCount,

    @Default(1) int currentPage,
    @Default(1) int totalPages,
  }) = _StudentStatusList;
}