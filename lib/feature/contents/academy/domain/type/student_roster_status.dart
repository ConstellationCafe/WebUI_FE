enum StudentRosterStatus {
  enrolled,
  graduation,
  expulsion,
  withdrawal,
}

extension StudentRosterStatusExtension on StudentRosterStatus {
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
    }
  }
}