class NotificationResponse {
  final int id;
  final String category;
  final String title;
  final String body;
  final String? link;
  final String targetType;
  final DateTime createdAt;
  final bool read;

  const NotificationResponse({
    required this.id,
    required this.category,
    required this.title,
    required this.body,
    required this.link,
    required this.targetType,
    required this.createdAt,
    required this.read,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      id: (json['id'] as num).toInt(),
      category: json['category'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      link: json['link'] as String?,
      targetType: json['targetType'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String).toUtc(),
      read: json['read'] as bool,
    );
  }
}
