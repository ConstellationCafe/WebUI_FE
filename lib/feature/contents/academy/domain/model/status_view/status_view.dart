import 'package:freezed_annotation/freezed_annotation.dart';

import '../academy.dart';
import '../academy_class.dart';
import '../../type/roster_status.dart';

part 'status_view.freezed.dart';

@freezed
abstract class StatusView<T, K extends RosterStatus>
    with _$StatusView<T, K> {
  const factory StatusView({
    required T academyMember,
    required Academy academy,
    required AcademyClass academyClass,
    required K status,
    DateTime? statusChangedAt,
    String? reason,
  }) = _StatusView<T, K>;
}