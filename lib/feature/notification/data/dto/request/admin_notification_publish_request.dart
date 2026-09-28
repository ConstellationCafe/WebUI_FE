class AdminNotificationPublishRequest {
  final String requestId;
  final String targetType;
  final String? targetDiscordId;
  final String category;
  final String title;
  final String body;
  final String? link;

  const AdminNotificationPublishRequest({
    required this.requestId,
    required this.targetType,
    required this.targetDiscordId,
    required this.category,
    required this.title,
    required this.body,
    required this.link,
  });

  /// 비어 있는 선택 값은 보내지 않는다. 채팅방 전체 알림에 대상 ID가 실리면
  /// Backend가 400으로 거부하므로 여기서 한 번 더 걸러낸다.
  Map<String, dynamic> toJson() {
    final target = targetDiscordId?.trim() ?? '';
    final trimmedLink = link?.trim() ?? '';
    return {
      'requestId': requestId,
      'targetType': targetType,
      if (targetType == 'USER' && target.isNotEmpty) 'targetDiscordId': target,
      'category': category,
      'title': title.trim(),
      'body': body.trim(),
      if (trimmedLink.isNotEmpty) 'link': trimmedLink,
    };
  }
}
