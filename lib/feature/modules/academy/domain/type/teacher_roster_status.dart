import 'package:constellation_cafe/feature/modules/academy/domain/type/roster_status.dart';

import '../../constants/academy_strings.dart';

enum TeacherRosterStatus implements RosterStatus {
  enrolled(AcademyStrings.enrolled, 'ENROLLED'),
  retirement(AcademyStrings.retirement, 'RETIRED'),
  disciplinary(AcademyStrings.disciplinary, 'DISCIPLINARY');

  @override
  final String label;

  @override
  final String apiValue;

  const TeacherRosterStatus(this.label, this.apiValue);

  static TeacherRosterStatus fromApiValue(String value) {
    return TeacherRosterStatus.values.firstWhere(
      (status) => status.apiValue == value,
      orElse: () => throw ArgumentError('지원하지 않는 교사 상태입니다: $value'),
    );
  }
}
