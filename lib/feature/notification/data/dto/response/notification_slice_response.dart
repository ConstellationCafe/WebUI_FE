import 'notification_response.dart';

class NotificationSliceResponse {
  final List<NotificationResponse> items;
  final bool hasNext;
  final int? nextBeforeId;
  final int lastReadId;

  const NotificationSliceResponse({
    required this.items,
    required this.hasNext,
    required this.nextBeforeId,
    required this.lastReadId,
  });

  factory NotificationSliceResponse.fromJson(Map<String, dynamic> json) {
    return NotificationSliceResponse(
      items: (json['items'] as List<dynamic>)
          .map(
            (item) =>
                NotificationResponse.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      hasNext: json['hasNext'] as bool,
      nextBeforeId: (json['nextBeforeId'] as num?)?.toInt(),
      lastReadId: (json['lastReadId'] as num).toInt(),
    );
  }
}
