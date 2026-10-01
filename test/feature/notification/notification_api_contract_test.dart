import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:test/test.dart';

import 'package:constellation_cafe/core/network/interceptors/error_interceptor.dart';
import 'package:constellation_cafe/feature/notification/data/api/admin_notification_api.dart';
import 'package:constellation_cafe/feature/notification/data/api/notification_api.dart';
import 'package:constellation_cafe/feature/notification/data/realtime/notification_event_source.dart';
import 'package:constellation_cafe/feature/notification/data/repository/admin_notification_repository.dart';
import 'package:constellation_cafe/feature/notification/data/repository/notification_repository.dart';
import 'package:constellation_cafe/feature/notification/domain/model/notification_draft.dart';
import 'package:constellation_cafe/feature/notification/domain/model/notification_publish_failure.dart';
import 'package:constellation_cafe/feature/notification/domain/model/notification_realtime_event.dart';
import 'package:constellation_cafe/feature/notification/domain/type/notification_category.dart';
import 'package:constellation_cafe/feature/notification/domain/type/notification_target_type.dart';

Map<String, dynamic> notificationJson({int id = 12, bool read = false}) => {
  'id': id,
  'category': 'POINT',
  'title': '포인트가 입금되었습니다',
  'body': '500포인트 입금 · 이벤트',
  'link': '/point_log',
  'targetType': 'USER',
  'createdAt': '2026-09-28T01:02:03.456Z',
  'read': read,
};

Map<String, dynamic> adminJson() => {
  'id': 5,
  'targetType': 'GUILD',
  'targetDiscordId': null,
  'category': 'ANNOUNCEMENT',
  'title': '점검 안내',
  'body': '오늘 밤 점검합니다.',
  'link': null,
  'source': 'ADMIN',
  'sourceRef': '42',
  'createdAt': '2026-09-28T01:00:00Z',
};

class _Frames implements NotificationEventSource {
  final List<NotificationStreamFrame> frames;

  _Frames(this.frames);

  @override
  bool get isSupported => true;

  @override
  Stream<NotificationStreamFrame> open(String url) =>
      Stream.fromIterable(frames);
}

void main() {
  late Dio dio;
  late RequestOptions request;
  late Map<String, dynamic> response;
  int status = 200;

  setUp(() {
    status = 200;
    response = {'success': true, 'response': <String, dynamic>{}};
    dio = Dio(BaseOptions(baseUrl: 'https://example.invalid'));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          request = options;
          final result = Response(
            requestOptions: options,
            statusCode: status,
            data: response,
          );
          if (status >= 400) {
            handler.reject(
              DioException.badResponse(
                statusCode: status,
                requestOptions: options,
                response: result,
              ),
            );
            return;
          }
          handler.resolve(result);
        },
      ),
    );
  });

  tearDown(() => dio.close());

  NotificationRepository memberRepository({
    List<NotificationStreamFrame> frames = const [],
  }) {
    return NotificationRepository(
      api: NotificationApi(dio: dio),
      eventSource: _Frames(frames),
    );
  }

  test('회원 알림 API는 본인 경로와 SSE 경로를 쓴다', () {
    expect(NotificationApi.path, endsWith('/api/me/notifications'));
    expect(NotificationApi.streamPath, endsWith('/notifications/stream'));
    expect(AdminNotificationApi.path, endsWith('/api/admin/notifications'));
  });

  test('목록은 beforeId 커서와 size를 보내고 UTC 시각과 읽음 여부를 변환한다', () async {
    response['response'] = {
      'items': [notificationJson()],
      'hasNext': true,
      'nextBeforeId': 12,
      'lastReadId': 10,
    };

    final page = await memberRepository().getNotifications(beforeId: 30);

    expect(request.method, 'GET');
    expect(request.path, NotificationApi.path);
    expect(request.queryParameters, {'beforeId': 30, 'size': 20});
    expect(request.extra[ErrorInterceptor.silentErrorKey], isTrue);
    final item = page.items.single;
    expect(item.category, NotificationCategory.point);
    expect(item.createdAt, DateTime.utc(2026, 9, 28, 1, 2, 3, 456));
    expect(item.link, '/point_log');
    expect(item.read, isFalse);
    expect(page.nextBeforeId, 12);
    expect(page.lastReadId, 10);
  });

  test('첫 페이지는 beforeId 없이 요청한다', () async {
    response['response'] = {
      'items': <dynamic>[],
      'hasNext': false,
      'nextBeforeId': null,
      'lastReadId': 0,
    };

    final page = await memberRepository().getNotifications();

    expect(request.queryParameters, {'size': 20});
    expect(page.items, isEmpty);
    expect(page.nextBeforeId, isNull);
  });

  test('읽음 처리는 PUT read-cursor로 마지막 ID를 보낸다', () async {
    response['response'] = {'unreadCount': 0, 'latestId': 12, 'lastReadId': 12};

    final summary = await memberRepository().markRead(12);

    expect(request.method, 'PUT');
    expect(request.path, '${NotificationApi.path}/read-cursor');
    expect(request.data, {'lastReadId': 12});
    expect(summary.hasUnread, isFalse);
  });

  test('알림이 없으면 latestId가 null인 요약을 받는다', () async {
    response['response'] = {
      'unreadCount': 0,
      'latestId': null,
      'lastReadId': 0,
    };

    final summary = await memberRepository().getUnreadSummary();

    expect(request.path, '${NotificationApi.path}/unread-count');
    expect(summary.latestId, isNull);
  });

  test('실시간 이벤트를 도메인 이벤트로 바꾸고 알 수 없는 이벤트는 건너뛴다', () async {
    final ready = {'unreadCount': 2, 'latestId': 12, 'lastReadId': 10};
    final unknownKind = {...notificationJson(id: 13), 'category': 'NEW_KIND'};
    final repository = memberRepository(
      frames: [
        NotificationStreamFrame(event: 'ready', data: jsonEncode(ready)),
        const NotificationStreamFrame(event: 'unknown', data: '{}'),
        const NotificationStreamFrame(event: 'notification', data: '{broken'),
        NotificationStreamFrame(
          event: 'notification',
          data: jsonEncode(unknownKind),
        ),
      ],
    );

    final events = await repository.watch().toList();

    expect(events, hasLength(2));
    final readyEvent = events[0] as NotificationRealtimeReady;
    expect(readyEvent.summary.unreadCount, 2);
    final received = events[1] as NotificationRealtimeReceived;
    expect(received.notification.id, 13);
    expect(
      received.notification.category,
      NotificationCategory.system,
      reason: '모르는 분류는 화면이 깨지지 않도록 system으로 본다',
    );
  });

  test('관리자 발행은 요청 ID와 대상을 계약대로 보낸다', () async {
    response['response'] = {'notification': adminJson(), 'created': true};
    final repository = AdminNotificationRepository(
      api: AdminNotificationApi(dio: dio),
    );

    final sent = await repository.publish(
      const NotificationDraft(
        requestId: 'req-1',
        targetType: NotificationTargetType.guild,
        targetDiscordId: '123',
        category: NotificationCategory.announcement,
        title: ' 점검 안내 ',
        body: ' 오늘 밤 점검합니다. ',
        link: '  ',
      ),
    );

    expect(request.method, 'POST');
    expect(request.path, AdminNotificationApi.path);
    final expected = {
      'requestId': 'req-1',
      'targetType': 'GUILD',
      'category': 'ANNOUNCEMENT',
      'title': '점검 안내',
      'body': '오늘 밤 점검합니다.',
    };
    // 채팅방 전체 알림에는 대상 ID와 빈 링크를 보내지 않는다.
    expect(request.data, expected);
    expect(sent.id, 5);
    expect(sent.targetType, NotificationTargetType.guild);
    expect(sent.createdAt, DateTime.utc(2026, 9, 28, 1));
  });

  test('개인 알림은 대상 Discord ID를 보낸다', () async {
    response['response'] = {'notification': adminJson(), 'created': true};
    final repository = AdminNotificationRepository(
      api: AdminNotificationApi(dio: dio),
    );

    await repository.publish(
      const NotificationDraft(
        requestId: 'req-2',
        targetType: NotificationTargetType.user,
        targetDiscordId: ' 123 ',
        category: NotificationCategory.point,
        title: '제목',
        body: '본문',
        link: '/point_log',
      ),
    );

    expect(request.data['targetType'], 'USER');
    expect(request.data['targetDiscordId'], '123');
    expect(request.data['link'], '/point_log');
  });

  const failures = {
    404: NotificationPublishFailure.notMember,
    409: NotificationPublishFailure.conflict,
    400: NotificationPublishFailure.invalid,
    503: NotificationPublishFailure.unknown,
  };
  for (final entry in failures.entries) {
    test('발행 실패 ${entry.key}는 ${entry.value}로 변환한다', () async {
      status = entry.key;
      response = {'success': false, 'response': null};
      final repository = AdminNotificationRepository(
        api: AdminNotificationApi(dio: dio),
      );

      const draft = NotificationDraft(
        requestId: 'req-3',
        targetType: NotificationTargetType.guild,
        targetDiscordId: null,
        category: NotificationCategory.event,
        title: '제목',
        body: '본문',
        link: null,
      );

      NotificationPublishFailure? reason;
      try {
        await repository.publish(draft);
      } on NotificationPublishException catch (error) {
        reason = error.reason;
      }

      expect(reason, entry.value);
    });
  }

  test('실패 응답을 정상 목록으로 처리하지 않는다', () async {
    response['success'] = false;
    await expectLater(
      memberRepository().getNotifications(),
      throwsFormatException,
    );
  });
}
