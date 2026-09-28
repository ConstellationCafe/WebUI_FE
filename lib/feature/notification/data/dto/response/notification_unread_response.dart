class NotificationUnreadResponse {
  final int unreadCount;
  final int? latestId;
  final int lastReadId;

  const NotificationUnreadResponse({
    required this.unreadCount,
    required this.latestId,
    required this.lastReadId,
  });

  factory NotificationUnreadResponse.fromJson(Map<String, dynamic> json) {
    return NotificationUnreadResponse(
      unreadCount: (json['unreadCount'] as num).toInt(),
      latestId: (json['latestId'] as num?)?.toInt(),
      lastReadId: (json['lastReadId'] as num).toInt(),
    );
  }
}
