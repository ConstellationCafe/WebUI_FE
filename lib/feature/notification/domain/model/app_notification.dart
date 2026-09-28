import '../type/notification_category.dart';

/// 회원에게 보이는 알림 한 건. [createdAt]은 UTC이며 표시할 때 지역 시간으로 바꾼다.
class AppNotification {
  final int id;
  final NotificationCategory category;
  final String title;
  final String body;
  final String? link;
  final DateTime createdAt;
  final bool read;

  const AppNotification({
    required this.id,
    required this.category,
    required this.title,
    required this.body,
    required this.link,
    required this.createdAt,
    required this.read,
  });

  @override
  bool operator ==(Object other) =>
      other is AppNotification &&
      other.id == id &&
      other.category == category &&
      other.title == title &&
      other.body == body &&
      other.link == link &&
      other.createdAt == createdAt &&
      other.read == read;

  @override
  int get hashCode =>
      Object.hash(id, category, title, body, link, createdAt, read);
}
