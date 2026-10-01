import 'admin_notification_response.dart';

class NotificationPublishResponse {
  final AdminNotificationResponse notification;
  final bool created;

  const NotificationPublishResponse({
    required this.notification,
    required this.created,
  });

  factory NotificationPublishResponse.fromJson(Map<String, dynamic> json) {
    return NotificationPublishResponse(
      notification: AdminNotificationResponse.fromJson(
        json['notification'] as Map<String, dynamic>,
      ),
      created: json['created'] as bool,
    );
  }
}
