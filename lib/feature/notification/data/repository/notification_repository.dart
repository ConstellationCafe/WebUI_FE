import 'dart:convert';

import '../../domain/model/app_notification.dart';
import '../../domain/model/notification_page.dart';
import '../../domain/model/notification_realtime_event.dart';
import '../../domain/model/unread_summary.dart';
import '../../domain/type/notification_category.dart';
import '../api/notification_api.dart';
import '../dto/request/notification_list_request.dart';
import '../dto/request/notification_read_cursor_request.dart';
import '../dto/response/notification_response.dart';
import '../dto/response/notification_unread_response.dart';
import '../realtime/notification_event_source.dart';

/// 회원 알림 조회·읽음·실시간 구독. DTO를 도메인 모델로 바꾸는 경계다.
class NotificationRepository {
  static const pageSize = 20;

  final NotificationApi api;
  final NotificationEventSource eventSource;

  const NotificationRepository({required this.api, required this.eventSource});

  bool get supportsRealtime => eventSource.isSupported;

  Future<NotificationPage> getNotifications({int? beforeId}) async {
    final response = await api.getNotifications(
      NotificationListRequest(beforeId: beforeId, size: pageSize),
    );
    return NotificationPage(
      items: response.items.map(_notification).toList(),
      hasNext: response.hasNext,
      nextBeforeId: response.nextBeforeId,
      lastReadId: response.lastReadId,
    );
  }

  Future<UnreadSummary> getUnreadSummary() async {
    return _summary(await api.getUnreadCount());
  }

  Future<UnreadSummary> markRead(int lastReadId) async {
    final request = NotificationReadCursorRequest(lastReadId: lastReadId);
    return _summary(await api.markRead(request));
  }

  /// 실시간 이벤트 스트림. 알 수 없는 이벤트나 깨진 JSON은 건너뛰고,
  /// 연결 종료([NotificationStreamClosedException])는 오류로 그대로 전달한다.
  Stream<NotificationRealtimeEvent> watch() async* {
    await for (final frame in eventSource.open(NotificationApi.streamPath)) {
      final event = _realtimeEvent(frame);
      if (event != null) yield event;
    }
  }

  NotificationRealtimeEvent? _realtimeEvent(NotificationStreamFrame frame) {
    try {
      final json = jsonDecode(frame.data) as Map<String, dynamic>;
      switch (frame.event) {
        case 'ready':
          final response = NotificationUnreadResponse.fromJson(json);
          return NotificationRealtimeReady(_summary(response));
        case 'notification':
          final response = NotificationResponse.fromJson(json);
          return NotificationRealtimeReceived(_notification(response));
      }
    } on FormatException {
      return null;
    } on TypeError {
      return null;
    }
    return null;
  }

  UnreadSummary _summary(NotificationUnreadResponse response) {
    return UnreadSummary(
      unreadCount: response.unreadCount,
      latestId: response.latestId,
      lastReadId: response.lastReadId,
    );
  }

  AppNotification _notification(NotificationResponse response) {
    return AppNotification(
      id: response.id,
      category: NotificationCategory.fromApi(response.category),
      title: response.title,
      body: response.body,
      link: response.link,
      createdAt: response.createdAt,
      read: response.read,
    );
  }
}
