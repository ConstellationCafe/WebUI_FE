import 'package:freezed_annotation/freezed_annotation.dart';

import '../status_view/status_view.dart';

part 'teacher_status_list.freezed.dart';

@freezed
abstract class TeacherStatusList
    with _$TeacherStatusList {
  const factory TeacherStatusList({
    @Default([])
    List<StatusView> items,

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