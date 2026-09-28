import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/core/network/DioProvider.dart';
import 'package:constellation_cafe/feature/guild_select/notifier/guild_state_notifier.dart';

import '../data/api/notification_api.dart';
import '../data/realtime/notification_event_source_factory.dart';
import '../data/repository/notification_repository.dart';
import '../domain/model/app_notification.dart';
import '../domain/model/notification_realtime_event.dart';
import '../domain/model/unread_summary.dart';
import '../state/notification_center_state.dart';

part 'notification_center_notifier.g.dart';

final notificationEventSourceProvider = Provider((ref) {
  return createNotificationEventSource();
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(
    api: NotificationApi(dio: ref.read(dioProvider)),
    eventSource: ref.read(notificationEventSourceProvider),
  );
});

/// 종 아이콘과 알림 패널의 상태를 소유한다.
///
/// 헤더가 보이는 동안(로그인한 채팅방 화면) 유지되며, 채팅방이 바뀌면 다시 만들어져
/// 새 채팅방의 알림을 구독한다. 실시간 연결이 서버 쪽에서 끝나면(토큰 만료 등)
/// 읽지 않은 개수를 REST로 먼저 다시 받아 토큰 갱신을 거친 뒤 지수 backoff로 재연결한다.
@riverpod
class NotificationCenterNotifier extends _$NotificationCenterNotifier {
  static const initialRetryDelay = Duration(seconds: 2);
  static const maxRetryDelay = Duration(seconds: 60);

  late NotificationRepository _repository;
  StreamSubscription<NotificationRealtimeEvent>? _subscription;
  Timer? _reconnectTimer;
  Duration _retryDelay = initialRetryDelay;
  final _random = Random();
  int _listRequest = 0;

  @override
  NotificationCenterState build() {
    ref.watch(currentGuildStateProvider.select((guild) => guild.guildId));
    _repository = ref.read(notificationRepositoryProvider);
    ref.onDispose(_stopRealtime);
    scheduleMicrotask(() {
      if (!ref.mounted) return;
      unawaited(refreshSummary());
      _connect();
    });
    return const NotificationCenterState();
  }

  /// 읽지 않은 개수를 다시 받는다. 실패하면 조용히 넘어가고 다음 연결에서 맞춘다.
  Future<void> refreshSummary() async {
    try {
      final summary = await _repository.getUnreadSummary();
      if (!ref.mounted) return;
      _applySummary(summary);
    } catch (_) {
      // 빨간 점은 실시간 연결의 ready 이벤트나 패널 열기에서 다시 맞춰진다.
    }
  }

  Future<void> openPanel() async {
    if (!ref.mounted) return;
    state = state.copyWith(isPanelOpen: true);
    await loadFirstPage();
  }

  void closePanel() {
    if (!ref.mounted) return;
    state = state.copyWith(isPanelOpen: false);
  }

  /// 최신 알림부터 다시 불러오고, 패널이 열려 있으면 본 알림까지 읽음 처리한다.
  Future<void> loadFirstPage() async {
    if (!ref.mounted) return;
    final request = ++_listRequest;
    state = state.copyWith(
      isLoading: true,
      isLoadingMore: false,
      hasError: false,
    );
    try {
      final page = await _repository.getNotifications();
      if (!ref.mounted || request != _listRequest) return;
      state = state.copyWith(
        items: page.items,
        hasNext: page.hasNext,
        nextBeforeId: page.nextBeforeId,
        lastReadId: page.lastReadId,
        isLoading: false,
        hasLoaded: true,
      );
      await _markVisibleAsRead();
    } catch (_) {
      if (!ref.mounted || request != _listRequest) return;
      state = state.copyWith(isLoading: false, hasError: true);
    }
  }

  Future<void> loadMore() async {
    final beforeId = state.nextBeforeId;
    if (!ref.mounted || beforeId == null) return;
    if (state.isLoading || state.isLoadingMore) return;
    final request = _listRequest;
    state = state.copyWith(isLoadingMore: true, hasError: false);
    try {
      final page = await _repository.getNotifications(beforeId: beforeId);
      if (!ref.mounted || request != _listRequest) return;
      state = state.copyWith(
        items: [...state.items, ...page.items],
        hasNext: page.hasNext,
        nextBeforeId: page.nextBeforeId,
        isLoadingMore: false,
      );
    } catch (_) {
      if (!ref.mounted || request != _listRequest) return;
      state = state.copyWith(isLoadingMore: false, hasError: true);
    }
  }

  Future<void> _markVisibleAsRead() async {
    if (!state.isPanelOpen || state.items.isEmpty) return;
    final newestId = state.items.first.id;
    if (newestId <= state.lastReadId && state.unreadCount == 0) return;
    try {
      final summary = await _repository.markRead(newestId);
      if (!ref.mounted) return;
      _applySummary(summary);
    } catch (_) {
      // 읽음 처리에 실패하면 빨간 점이 남고, 다음에 패널을 열 때 다시 시도한다.
    }
  }

  void _applySummary(UnreadSummary summary) {
    state = state.copyWith(
      unreadCount: summary.unreadCount,
      latestId: summary.latestId,
      lastReadId: summary.lastReadId,
    );
  }

  void _connect() {
    if (!ref.mounted || !_repository.supportsRealtime) return;
    _reconnectTimer?.cancel();
    unawaited(_subscription?.cancel());
    _subscription = _repository.watch().listen(
      _onRealtimeEvent,
      onError: (Object _) => _scheduleReconnect(),
      onDone: _scheduleReconnect,
      cancelOnError: true,
    );
  }

  void _onRealtimeEvent(NotificationRealtimeEvent event) {
    if (!ref.mounted) return;
    switch (event) {
      case NotificationRealtimeReady(:final summary):
        _retryDelay = initialRetryDelay;
        state = state.copyWith(isRealtimeConnected: true);
        _applySummary(summary);
        _reloadOpenPanelIfBehind(summary);
      case NotificationRealtimeReceived(:final notification):
        _receive(notification);
    }
  }

  /// 끊긴 동안 새 알림이 쌓였고 패널이 열려 있으면 목록을 다시 맞춘다.
  void _reloadOpenPanelIfBehind(UnreadSummary summary) {
    final latestId = summary.latestId;
    if (!state.isPanelOpen || latestId == null) return;
    final newestShown = state.items.isEmpty ? 0 : state.items.first.id;
    if (latestId > newestShown) unawaited(loadFirstPage());
  }

  void _receive(AppNotification notification) {
    // 같은 알림이 두 번 전달될 수 있으므로(ADR-0004) ID로 중복을 거른다.
    final knownLatest = state.latestId ?? 0;
    final alreadyShown = state.items.any((item) => item.id == notification.id);
    final isNew = notification.id > knownLatest;
    final isUnread = isNew && notification.id > state.lastReadId;
    final showInList = state.hasLoaded && !alreadyShown;
    state = state.copyWith(
      items: showInList ? [notification, ...state.items] : state.items,
      latestId: isNew ? notification.id : state.latestId,
      unreadCount: isUnread ? state.unreadCount + 1 : state.unreadCount,
    );
    if (isUnread) unawaited(_markVisibleAsRead());
  }

  void _scheduleReconnect() {
    if (!ref.mounted) return;
    _subscription = null;
    state = state.copyWith(isRealtimeConnected: false);
    final delay = _withJitter(_retryDelay);
    final doubled = _retryDelay * 2;
    _retryDelay = doubled > maxRetryDelay ? maxRetryDelay : doubled;
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () async {
      if (!ref.mounted) return;
      // 401로 끊겼다면 이 REST 호출이 AuthInterceptor의 토큰 갱신을 먼저 거친다.
      await refreshSummary();
      _connect();
    });
  }

  Duration _withJitter(Duration base) {
    final factor = 0.8 + _random.nextDouble() * 0.4;
    return Duration(milliseconds: (base.inMilliseconds * factor).round());
  }

  void _stopRealtime() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    unawaited(_subscription?.cancel());
    _subscription = null;
  }
}
