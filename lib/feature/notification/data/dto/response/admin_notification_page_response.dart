import 'admin_notification_response.dart';

class AdminNotificationPageResponse {
  final List<AdminNotificationResponse> items;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;
  final bool hasNext;

  const AdminNotificationPageResponse({
    required this.items,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
    required this.hasNext,
  });

  factory AdminNotificationPageResponse.fromJson(Map<String, dynamic> json) {
    return AdminNotificationPageResponse(
      items: (json['items'] as List<dynamic>)
          .map(
            (item) => AdminNotificationResponse.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      totalElements: (json['totalElements'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      hasNext: json['hasNext'] as bool,
    );
  }
}
