class DateFormatter {
  const DateFormatter._();

  static String toYyyyMmDd(
      DateTime? date, {
        String fallback = '-',
      }) {
    if (date == null) {
      return fallback;
    }

    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }
}