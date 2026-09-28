import 'package:intl/intl.dart';

import '../constants/notification_strings.dart';

/// 알림 시각 표시. 하루 이내는 상대 시간, 그 이후는 사용자 지역 시간의 날짜로 보여준다.
/// [now]를 받아 테스트에서 시각을 고정할 수 있게 한다.
String formatNotificationTime(DateTime createdAt, DateTime now) {
  final elapsed = now.difference(createdAt);
  if (elapsed.inMinutes < 1) return NotificationStrings.justNow;
  if (elapsed.inHours < 1) {
    return NotificationStrings.minutesAgo(elapsed.inMinutes);
  }
  if (elapsed.inDays < 1) return NotificationStrings.hoursAgo(elapsed.inHours);
  return formatNotificationDate(createdAt);
}

/// 사용자 지역 시간 기준 날짜와 시각.
String formatNotificationDate(DateTime createdAt) {
  return DateFormat('yyyy.MM.dd HH:mm').format(createdAt.toLocal());
}
