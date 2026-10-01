import 'package:constellation_cafe/feature/modules/academy/domain/type/status_type.dart';

import '../../constants/academy_strings.dart';

enum StudentStatusType implements StatusType {
  graduation(AcademyStrings.graduated, 'GRADUATED'),
  expulsion(AcademyStrings.expelled, 'EXPELLED'),
  withdrawal(AcademyStrings.withdrawn, 'WITHDRAWN');

  @override
  final String label;

  @override
  final String apiValue;

  const StudentStatusType(this.label, this.apiValue);

  static StudentStatusType fromApiValue(String value) {
    return StudentStatusType.values.firstWhere(
      (status) => status.apiValue == value,
      orElse: () => throw ArgumentError('지원하지 않는 학생 상태 처리 유형입니다: $value'),
    );
  }
}
