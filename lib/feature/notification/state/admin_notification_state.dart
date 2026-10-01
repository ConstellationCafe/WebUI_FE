import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/model/sent_notification.dart';

part 'admin_notification_state.freezed.dart';

/// 관리자 알림 발행 화면 상태. 입력값은 폼 위젯이 소유하고,
/// 여기에는 발행 진행과 발행 이력 조회 상태만 둔다.
@freezed
abstract class AdminNotificationState with _$AdminNotificationState {
  const factory AdminNotificationState({
    @Default([]) List<SentNotification> history,
    @Default(1) int historyPage,
    @Default(0) int historyTotalPages,
    @Default(false) bool isLoadingHistory,
    @Default(false) bool hasHistoryError,
    @Default(false) bool isSubmitting,
  }) = _AdminNotificationState;
}
