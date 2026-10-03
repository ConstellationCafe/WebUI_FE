/// 공용 날짜·시간 선택 입력란 문구.
abstract final class DateTimePickerStrings {
  static const selectDate = '날짜 선택';
  static const selectTime = '시간 선택';
  static const emptyTime = '--:--';
  static const clear = '지우기';
  static const changeDate = '날짜 변경';
  static const changeTime = '시간 변경';

  /// 현지 시각 `yyyy-MM-dd`
  static String formatDate(DateTime value) =>
      '${value.year}-${_two(value.month)}-${_two(value.day)}';

  /// 현지 시각 24시간제 `HH:mm`
  static String formatTime(DateTime value) =>
      '${_two(value.hour)}:${_two(value.minute)}';

  static String _two(int value) => value.toString().padLeft(2, '0');
}
