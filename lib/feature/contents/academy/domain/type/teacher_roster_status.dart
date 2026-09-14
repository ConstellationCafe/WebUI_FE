import 'package:constellation_cafe/feature/contents/academy/domain/type/roster_status.dart';

enum TeacherRosterStatus implements RosterStatus {
  enrolled('재적', 'ENROLLED'),
  retirement('은퇴', 'RETIRED'),
  disciplinary('징계', 'DISCIPLINARY');

  @override
  final String label;

  @override
  final String apiValue;

  const TeacherRosterStatus(
      this.label,
      this.apiValue,
      );

  static TeacherRosterStatus fromApiValue(String value) {
    return TeacherRosterStatus.values.firstWhere(
          (status) => status.apiValue == value,
      orElse: () => throw ArgumentError(
        '지원하지 않는 교사 상태입니다: $value',
      ),
    );
  }
}