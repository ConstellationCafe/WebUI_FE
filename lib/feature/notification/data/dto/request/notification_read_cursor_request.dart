class NotificationReadCursorRequest {
  final int lastReadId;

  const NotificationReadCursorRequest({required this.lastReadId});

  Map<String, dynamic> toJson() => {'lastReadId': lastReadId};
}
