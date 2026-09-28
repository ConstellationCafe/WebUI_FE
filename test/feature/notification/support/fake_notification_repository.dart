import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/notification/data/repository/notification_repository.dart';
import 'package:constellation_cafe/feature/notification/domain/model/app_notification.dart';
import 'package:constellation_cafe/feature/notification/domain/model/notification_page.dart';
import 'package:constellation_cafe/feature/notification/domain/model/notification_realtime_event.dart';
import 'package:constellation_cafe/feature/notification/domain/model/unread_summary.dart';
import 'package:constellation_cafe/feature/notification/domain/type/notification_category.dart';

AppNotification appNotification(int id, {bool read = false}) {
  return AppNotification(
    id: id,
    category: NotificationCategory.announcement,
    title: '공지 $id',
    body: '본문 $id',
    link: null,
    createdAt: DateTime.utc(2026, 9, 28, 1),
    read: read,
  );
}

UnreadSummary summary(int unread, {int? latestId, int lastReadId = 0}) {
  return UnreadSummary(
    unreadCount: unread,
    latestId: latestId,
    lastReadId: lastReadId,
  );
}

/// 네트워크 없이 알림 저장소 동작을 흉내 낸다. 실시간 스트림은 테스트가 직접 흘려보낸다.
class FakeNotificationRepository extends Fake
    implements NotificationRepository {
  UnreadSummary unreadSummary = summary(0);
  List<AppNotification> firstPage = [];
  int lastReadId = 0;
  bool realtime = true;
  Object? listError;
  final markReadCalls = <int>[];
  final pageRequests = <int?>[];
  var watchCount = 0;
  StreamController<NotificationRealtimeEvent>? controller;

  @override
  bool get supportsRealtime => realtime;

  @override
  Future<UnreadSummary> getUnreadSummary() async => unreadSummary;

  @override
  Future<NotificationPage> getNotifications({int? beforeId}) async {
    pageRequests.add(beforeId);
    final error = listError;
    if (error != null) throw error;
    var items = firstPage;
    if (beforeId != null) items = [appNotification(beforeId - 1, read: true)];
    return NotificationPage(
      items: items,
      hasNext: beforeId == null && items.isNotEmpty,
      nextBeforeId: items.isEmpty ? null : items.last.id,
      lastReadId: lastReadId,
    );
  }

  @override
  Future<UnreadSummary> markRead(int id) async {
    markReadCalls.add(id);
    lastReadId = id;
    unreadSummary = summary(0, latestId: id, lastReadId: id);
    return unreadSummary;
  }

  @override
  Stream<NotificationRealtimeEvent> watch() {
    watchCount++;
    final next = StreamController<NotificationRealtimeEvent>();
    controller = next;
    return next.stream;
  }

  void emit(NotificationRealtimeEvent event) => controller!.add(event);

  /// 서버가 연결을 끝낸 상황(토큰 만료 등).
  void closeWithError() {
    controller!.addError(StateError('closed'));
  }
}
