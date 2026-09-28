import '../type/notification_category.dart';
import '../type/notification_target_type.dart';

/// 관리자가 작성한 발행 내용. [requestId]는 한 번의 발행 시도를 식별해
/// 네트워크 오류로 다시 보내도 알림이 두 번 생기지 않게 한다.
class NotificationDraft {
  final String requestId;
  final NotificationTargetType targetType;
  final String? targetDiscordId;
  final NotificationCategory category;
  final String title;
  final String body;
  final String? link;

  const NotificationDraft({
    required this.requestId,
    required this.targetType,
    required this.targetDiscordId,
    required this.category,
    required this.title,
    required this.body,
    required this.link,
  });
}
