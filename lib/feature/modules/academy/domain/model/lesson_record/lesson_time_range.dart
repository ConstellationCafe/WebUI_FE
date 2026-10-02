/// 수업 시작·종료 시각(시:분)으로 수업 시간을 계산하는 규칙.
///
/// 수업 기록은 교육 일자와 시:분만 저장하므로, 종료 시각이 시작 시각보다
/// 이르면 자정을 넘겨 다음 날 끝난 수업으로 본다(예: 22:30 ~ 02:00 → 210분).
/// 시작과 종료가 같으면 수업 시간이 0분이므로 유효하지 않다.
abstract final class LessonTimeRange {
  static const int _minutesPerDay = Duration.minutesPerDay;

  /// 자정 기준 경과 분으로 받은 시작·종료 시각 사이의 수업 시간(분).
  static int durationMinutes(int startMinutes, int endMinutes) {
    // Dart의 %는 양수 제수에 대해 항상 0 이상을 돌려준다.
    return (endMinutes - startMinutes) % _minutesPerDay;
  }

  static bool isValidMinutes(int startMinutes, int endMinutes) =>
      durationMinutes(startMinutes, endMinutes) > 0;

  static bool endsNextDayMinutes(int startMinutes, int endMinutes) =>
      endMinutes < startMinutes;

  /// [start], [end]의 날짜 부분은 무시하고 시:분만 사용한다.
  static Duration duration(DateTime start, DateTime end) {
    final minutes = durationMinutes(_minutesOf(start), _minutesOf(end));
    return Duration(minutes: minutes);
  }

  static bool isValid(DateTime start, DateTime end) =>
      isValidMinutes(_minutesOf(start), _minutesOf(end));

  static bool endsNextDay(DateTime start, DateTime end) =>
      endsNextDayMinutes(_minutesOf(start), _minutesOf(end));

  static int _minutesOf(DateTime time) =>
      time.hour * Duration.minutesPerHour + time.minute;
}
