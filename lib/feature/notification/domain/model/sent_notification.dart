import '../type/notification_category.dart';
import '../type/notification_target_type.dart';

/// 관리자 발행 이력에 보이는 알림.
class SentNotification {
  final int id;
  final NotificationTargetType targetType;
  final String? targetDiscordId;
  final NotificationCategory category;
  final String title;
  final String body;
  final String? link;
  final String source;
  final String sourceRef;
  final DateTime createdAt;

  const SentNotification({
    required this.id,
    required this.targetType,
    required this.targetDiscordId,
    required this.category,
    required this.title,
    required this.body,
    required this.link,
    required this.source,
    required this.sourceRef,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      other is SentNotification &&
      other.id == id &&
      other.targetType == targetType &&
      other.targetDiscordId == targetDiscordId &&
      other.category == category &&
      other.title == title &&
      other.body == body &&
      other.link == link &&
      other.source == source &&
      other.sourceRef == sourceRef &&
      other.createdAt == createdAt;

  @override
  int get hashCode => Object.hash(
    id,
    targetType,
    targetDiscordId,
    category,
    title,
    body,
    link,
    source,
    sourceRef,
    createdAt,
  );
}

class SentNotificationPage {
  final List<SentNotification> items;
  final int page;
  final int totalPages;

  const SentNotificationPage({
    required this.items,
    required this.page,
    required this.totalPages,
  });
}
