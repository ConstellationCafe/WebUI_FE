import 'package:freezed_annotation/freezed_annotation.dart';

import '../academy.dart';
import '../academy_class.dart';
import '../student.dart';
import '../../type/student_roster_status.dart';

part 'student_status_view.freezed.dart';

@freezed
abstract class StudentStatusView with _$StudentStatusView {
  const factory StudentStatusView({
    required Student student,
    required Academy academy,
    required AcademyClass academyClass,
    required StudentRosterStatus status,
    DateTime? changedAt,
    String? reason,
  }) = _StudentStatusView;
}