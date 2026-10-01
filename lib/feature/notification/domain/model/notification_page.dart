import 'app_notification.dart';

/// ID 커서 기반 알림 목록 한 페이지.
class NotificationPage {
  final List<AppNotification> items;
  final bool hasNext;
  final int? nextBeforeId;
  final int lastReadId;

  const NotificationPage({
    required this.items,
    required this.hasNext,
    required this.nextBeforeId,
    required this.lastReadId,
  });
}
