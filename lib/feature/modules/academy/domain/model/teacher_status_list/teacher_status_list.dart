import 'package:freezed_annotation/freezed_annotation.dart';

import '../../type/teacher_roster_status.dart';
import '../status_view/status_view.dart';
import '../teacher.dart';

part 'teacher_status_list.freezed.dart';

@freezed
abstract class TeacherStatusList
    with _$TeacherStatusList {
  const factory TeacherStatusList({
    @Default(
      <StatusView<Teacher, TeacherRosterStatus>>[],
    )
    List<StatusView<Teacher, TeacherRosterStatus>> items,

    @Default(0)
    int totalCount,

    @Default(0)
    int enrolledCount,

    @Default(0)
    int retirementCount,

    @Default(0)
    int disciplinaryCount,

    @Default(1)
    int currentPage,

    @Default(1)
    int totalPages,
  }) = _TeacherStatusList;
}