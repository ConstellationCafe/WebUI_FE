import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

import 'notification_event_source.dart';

/// 브라우저 EventSource 기반 구현.
///
/// 인증은 HttpOnly AccessToken 쿠키로 하므로 토큰을 URL에 싣지 않는다.
/// 쿠키가 교차 출처 배포에서도 실리도록 withCredentials를 켠다.
NotificationEventSource createNotificationEventSource() =>
    const _BrowserNotificationEventSource();

class _BrowserNotificationEventSource implements NotificationEventSource {
  static const _eventNames = ['ready', 'notification'];
  static const _closed = 2;

  const _BrowserNotificationEventSource();

  @override
  bool get isSupported => true;

  @override
  Stream<NotificationStreamFrame> open(String url) {
    web.EventSource? source;
    late final StreamController<NotificationStreamFrame> controller;

    void close() {
      source?.close();
      source = null;
    }

    controller = StreamController<NotificationStreamFrame>(
      onListen: () {
        final eventSource = web.EventSource(
          url,
          web.EventSourceInit(withCredentials: true),
        );
        source = eventSource;
        for (final name in _eventNames) {
          eventSource.addEventListener(
            name,
            ((web.MessageEvent event) {
              final data = event.data?.dartify();
              if (data is String && !controller.isClosed) {
                controller.add(
                  NotificationStreamFrame(event: name, data: data),
                );
              }
            }).toJS,
          );
        }
        eventSource.onerror = ((web.Event _) {
          // CONNECTING이면 브라우저가 재연결 중이다. CLOSED만 호출자에게 알린다.
          if (eventSource.readyState != _closed || controller.isClosed) return;
          close();
          controller.addError(const NotificationStreamClosedException());
          controller.close();
        }).toJS;
      },
      onCancel: close,
    );
    return controller.stream;
  }
}
