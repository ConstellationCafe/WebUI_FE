class NotificationListRequest {
  final int? beforeId;
  final int size;

  const NotificationListRequest({this.beforeId, this.size = 20});

  Map<String, dynamic> toJson() => {
    if (beforeId != null) 'beforeId': beforeId,
    'size': size,
  };
}
