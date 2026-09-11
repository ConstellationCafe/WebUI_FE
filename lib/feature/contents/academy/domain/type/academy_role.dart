enum AcademyRole {
  academyOwner,
  teacher,
  student;

  String get apiValue {
    switch (this) {
      case AcademyRole.academyOwner:
        return 'ACADEMY_OWNER';
      case AcademyRole.teacher:
        return 'TEACHER';
      case AcademyRole.student:
        return 'STUDENT';
    }
  }

  static AcademyRole fromApiValue(String value) {
    switch (value) {
      case 'ACADEMY_OWNER':
        return AcademyRole.academyOwner;
      case 'TEACHER':
        return AcademyRole.teacher;
      case 'STUDENT':
        return AcademyRole.student;
      default:
        throw ArgumentError(
          'Unknown AcademyRole: $value',
        );
    }
  }
}