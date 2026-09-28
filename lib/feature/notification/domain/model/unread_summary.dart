/// 읽지 않은 알림 요약. 종 아이콘의 빨간 점은 [hasUnread]로 결정한다.
class UnreadSummary {
  final int unreadCount;
  final int? latestId;
  final int lastReadId;

  const UnreadSummary({
    required this.unreadCount,
    required this.latestId,
    required this.lastReadId,
  });

  bool get hasUnread => unreadCount > 0;
}
