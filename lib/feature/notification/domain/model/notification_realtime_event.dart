import 'app_notification.dart';
import 'unread_summary.dart';

/// 실시간 연결에서 받은 이벤트.
sealed class NotificationRealtimeEvent {
  const NotificationRealtimeEvent();
}

/// 연결(재연결) 직후 서버가 보내는 읽지 않은 요약. 끊긴 동안 놓친 상태를 이 값으로 맞춘다.
final class NotificationRealtimeReady extends NotificationRealtimeEvent {
  final UnreadSummary summary;

  const NotificationRealtimeReady(this.summary);
}

/// 새로 발행된 알림 한 건.
final class NotificationRealtimeReceived extends NotificationRealtimeEvent {
  final AppNotification notification;

  const NotificationRealtimeReceived(this.notification);
}
