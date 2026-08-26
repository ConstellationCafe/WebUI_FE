enum StudentRosterStatus {
  enrolled,
  graduation,
  expulsion,
  withdrawal,
  retirement,
  disciplinary,
}

extension StudentRosterStatusExtension
on StudentRosterStatus {
  String get label {
    switch (this) {
      case StudentRosterStatus.enrolled:
        return '재적';

      case StudentRosterStatus.graduation:
        return '졸업';

      case StudentRosterStatus.expulsion:
        return '퇴학';

      case StudentRosterStatus.withdrawal:
        return '자퇴';

      case StudentRosterStatus.retirement:
        return '은퇴';

      case StudentRosterStatus.disciplinary:
        return '징계';
    }
  }

  String get apiValue {
    switch (this) {
      case StudentRosterStatus.enrolled:
        return 'ENROLLED';

      case StudentRosterStatus.graduation:
        return 'GRADUATED';

      case StudentRosterStatus.expulsion:
        return 'EXPELLED';

      case StudentRosterStatus.withdrawal:
        return 'WITHDRAWN';

      case StudentRosterStatus.retirement:
        return 'RETIRED';

      case StudentRosterStatus.disciplinary:
        return 'DISCIPLINARY';
    }
  }

  static StudentRosterStatus fromApiValue(
      String value,
      ) {
    switch (value) {
      case 'ENROLLED':
        return StudentRosterStatus.enrolled;

      case 'GRADUATED':
        return StudentRosterStatus.graduation;

      case 'EXPELLED':
        return StudentRosterStatus.expulsion;

      case 'WITHDRAWN':
        return StudentRosterStatus.withdrawal;

      case 'RETIRED':
        return StudentRosterStatus.retirement;

      case 'DISCIPLINARY':
        return StudentRosterStatus.disciplinary;

      default:
        throw ArgumentError(
          '지원하지 않는 학생 상태입니다: $value',
        );
    }
  }
}