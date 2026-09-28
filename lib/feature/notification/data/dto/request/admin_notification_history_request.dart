class AdminNotificationHistoryRequest {
  final int page;
  final int size;

  const AdminNotificationHistoryRequest({required this.page, this.size = 20});

  Map<String, dynamic> toJson() => {'page': page, 'size': size};
}
