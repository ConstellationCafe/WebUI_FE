import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/core/network/dio_provider.dart';

import '../data/api/admin_notification_api.dart';
import '../data/repository/admin_notification_repository.dart';
import '../domain/model/notification_draft.dart';
import '../domain/model/notification_publish_failure.dart';
import '../state/admin_notification_state.dart';

part 'admin_notification_notifier.g.dart';

final adminNotificationRepositoryProvider = Provider((ref) {
  return AdminNotificationRepository(
    api: AdminNotificationApi(dio: ref.read(dioProvider)),
  );
});

/// 관리자 알림 발행과 발행 이력.
@riverpod
class AdminNotificationNotifier extends _$AdminNotificationNotifier {
  late AdminNotificationRepository _repository;
  int _historyRequest = 0;

  @override
  AdminNotificationState build() {
    _repository = ref.read(adminNotificationRepositoryProvider);
    scheduleMicrotask(() {
      if (ref.mounted && _historyRequest == 0) unawaited(loadHistory());
    });
    return const AdminNotificationState(isLoadingHistory: true);
  }

  Future<void> loadHistory({int page = 1}) async {
    if (!ref.mounted) return;
    final request = ++_historyRequest;
    state = state.copyWith(isLoadingHistory: true, hasHistoryError: false);
    try {
      final result = await _repository.getHistory(page: page);
      if (!ref.mounted || request != _historyRequest) return;
      state = state.copyWith(
        history: result.items,
        historyPage: result.page,
        historyTotalPages: result.totalPages,
        isLoadingHistory: false,
      );
    } catch (_) {
      if (!ref.mounted || request != _historyRequest) return;
      state = state.copyWith(isLoadingHistory: false, hasHistoryError: true);
    }
  }

  /// 발행에 성공하면 null, 실패하면 이유를 돌려준다. 진행 중에는 중복 실행하지 않는다.
  Future<NotificationPublishFailure?> publish(NotificationDraft draft) async {
    if (!ref.mounted || state.isSubmitting) {
      return NotificationPublishFailure.unknown;
    }
    state = state.copyWith(isSubmitting: true);
    try {
      await _repository.publish(draft);
      if (!ref.mounted) return null;
      state = state.copyWith(isSubmitting: false);
      unawaited(loadHistory());
      return null;
    } on NotificationPublishException catch (error) {
      if (ref.mounted) state = state.copyWith(isSubmitting: false);
      return error.reason;
    } catch (_) {
      if (ref.mounted) state = state.copyWith(isSubmitting: false);
      return NotificationPublishFailure.unknown;
    }
  }
}
