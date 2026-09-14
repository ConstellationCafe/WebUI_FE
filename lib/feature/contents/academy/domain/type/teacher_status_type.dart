import 'package:constellation_cafe/feature/contents/academy/domain/type/status_type.dart';

enum TeacherStatusType implements StatusType {
  retire('퇴직', 'RETIRED'),
  discipline('징계', 'DISCIPLINARY');

  @override
  final String label;

  @override
  final String apiValue;

  const TeacherStatusType(
      this.label,
      this.apiValue,
      );

  static TeacherStatusType fromApiValue(String value) {
    return TeacherStatusType.values.firstWhere(
          (status) => status.apiValue == value,
      orElse: () => throw ArgumentError(
        '지원하지 않는 교사 상태 처리 유형입니다: $value',
      ),
    );
  }
}