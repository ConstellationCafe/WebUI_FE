import 'package:constellation_cafe/feature/contents/academy/domain/type/status_type.dart';

enum StudentStatusType implements StatusType {
  graduation('졸업', 'GRADUATED'),
  expulsion('퇴학', 'EXPELLED'),
  withdrawal('자퇴', 'WITHDRAWN');

  @override
  final String label;

  @override
  final String apiValue;

  const StudentStatusType(
      this.label,
      this.apiValue,
      );

  static StudentStatusType fromApiValue(String value) {
    return StudentStatusType.values.firstWhere(
          (status) => status.apiValue == value,
      orElse: () => throw ArgumentError(
        '지원하지 않는 학생 상태 처리 유형입니다: $value',
      ),
    );
  }
}