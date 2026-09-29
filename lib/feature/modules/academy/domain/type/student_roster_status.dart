import 'package:constellation_cafe/feature/modules/academy/domain/type/roster_status.dart';

import '../../constants/academy_strings.dart';

enum StudentRosterStatus implements RosterStatus {
  enrolled(AcademyStrings.enrolled, 'ENROLLED'),
  graduation(AcademyStrings.graduated, 'GRADUATED'),
  expulsion(AcademyStrings.expelled, 'EXPELLED'),
  withdrawal(AcademyStrings.withdrawn, 'WITHDRAWN');

  @override
  final String label;
  @override
  final String apiValue;

  const StudentRosterStatus(this.label, this.apiValue);

  static StudentRosterStatus fromApiValue(String value) {
    return StudentRosterStatus.values.firstWhere(
      (status) => status.apiValue == value,
      orElse: () => throw ArgumentError('지원하지 않는 학생 상태입니다: $value'),
    );
  }
}
