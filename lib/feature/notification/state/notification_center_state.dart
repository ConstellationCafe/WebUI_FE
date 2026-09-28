import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/model/app_notification.dart';

part 'notification_center_state.freezed.dart';

/// 종 아이콘과 알림 패널이 공유하는 상태.
///
/// 빨간 점은 [unreadCount]로, 패널 목록은 [items]로 그린다. 목록 로딩(첫 페이지·더 보기)과
/// 실패를 따로 두어 단일 isLoading으로 화면 상태를 뭉개지 않는다(flutter.md).
@freezed
abstract class NotificationCenterState with _$NotificationCenterState {
  const factory NotificationCenterState({
    @Default([]) List<AppNotification> items,
    @Default(0) int unreadCount,
    int? latestId,
    @Default(0) int lastReadId,
    @Default(false) bool isPanelOpen,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasLoaded,
    @Default(false) bool hasError,
    @Default(false) bool hasNext,
    int? nextBeforeId,
    @Default(false) bool isRealtimeConnected,
  }) = _NotificationCenterState;
}
