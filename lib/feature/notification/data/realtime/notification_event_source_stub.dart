import 'notification_event_source.dart';

/// Web 이외 플랫폼용 구현. 실시간 연결 없이 REST 조회(패널 열기, 재조회)만 사용한다.
NotificationEventSource createNotificationEventSource() =>
    const _UnsupportedNotificationEventSource();

class _UnsupportedNotificationEventSource implements NotificationEventSource {
  const _UnsupportedNotificationEventSource();

  @override
  bool get isSupported => false;

  @override
  Stream<NotificationStreamFrame> open(String url) => const Stream.empty();
}
