import 'package:dio/dio.dart';

import '../../domain/model/notification_draft.dart';
import '../../domain/model/notification_publish_failure.dart';
import '../../domain/model/sent_notification.dart';
import '../../domain/type/notification_category.dart';
import '../../domain/type/notification_target_type.dart';
import '../api/admin_notification_api.dart';
import '../dto/request/admin_notification_history_request.dart';
import '../dto/request/admin_notification_publish_request.dart';
import '../dto/response/admin_notification_response.dart';

class AdminNotificationRepository {
  final AdminNotificationApi api;

  const AdminNotificationRepository({required this.api});

  /// 실패는 [NotificationPublishException]으로 바꿔 던진다.
  Future<SentNotification> publish(NotificationDraft draft) async {
    final request = AdminNotificationPublishRequest(
      requestId: draft.requestId,
      targetType: draft.targetType.apiValue,
      targetDiscordId: draft.targetDiscordId,
      category: draft.category.apiValue,
      title: draft.title,
      body: draft.body,
      link: draft.link,
    );
    try {
      final response = await api.publish(request);
      return _sent(response.notification);
    } on DioException catch (error) {
      throw NotificationPublishException(_failure(error.response?.statusCode));
    }
  }

  NotificationPublishFailure _failure(int? statusCode) {
    return switch (statusCode) {
      404 => NotificationPublishFailure.notMember,
      409 => NotificationPublishFailure.conflict,
      400 => NotificationPublishFailure.invalid,
      _ => NotificationPublishFailure.unknown,
    };
  }

  Future<SentNotificationPage> getHistory({required int page}) async {
    final response = await api.getHistory(
      AdminNotificationHistoryRequest(page: page),
    );
    return SentNotificationPage(
      items: response.items.map(_sent).toList(),
      page: response.page,
      totalPages: response.totalPages,
    );
  }

  SentNotification _sent(AdminNotificationResponse response) {
    return SentNotification(
      id: response.id,
      targetType: NotificationTargetType.fromApi(response.targetType),
      targetDiscordId: response.targetDiscordId,
      category: NotificationCategory.fromApi(response.category),
      title: response.title,
      body: response.body,
      link: response.link,
      source: response.source,
      sourceRef: response.sourceRef,
      createdAt: response.createdAt,
    );
  }
}
