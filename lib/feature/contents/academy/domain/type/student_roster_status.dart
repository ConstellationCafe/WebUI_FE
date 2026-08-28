import 'package:constellation_cafe/feature/contents/academy/domain/type/roster_status.dart';

enum StudentRosterStatus implements RosterStatus {
  enrolled('재적', 'ENROLLED'),
  graduation('졸업', 'GRADUATED'),
  expulsion('퇴학', 'EXPELLED'),
  withdrawal('자퇴', 'WITHDRAWN');

  @override
  final String label;
  @override
  final String apiValue;

  const StudentRosterStatus(
      this.label,
      this.apiValue,
  );

  static StudentRosterStatus fromApiValue(String value) {
    return StudentRosterStatus.values.firstWhere(
        (status) => status.apiValue == value,
        orElse: () => throw ArgumentError(
          '지원하지 않는 학생 상태입니다: $value',
        ),
    );
  }
}