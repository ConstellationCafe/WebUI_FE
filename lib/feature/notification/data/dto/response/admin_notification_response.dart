class AdminNotificationResponse {
  final int id;
  final String targetType;
  final String? targetDiscordId;
  final String category;
  final String title;
  final String body;
  final String? link;
  final String source;
  final String sourceRef;
  final DateTime createdAt;

  const AdminNotificationResponse({
    required this.id,
    required this.targetType,
    required this.targetDiscordId,
    required this.category,
    required this.title,
    required this.body,
    required this.link,
    required this.source,
    required this.sourceRef,
    required this.createdAt,
  });

  factory AdminNotificationResponse.fromJson(Map<String, dynamic> json) {
    return AdminNotificationResponse(
      id: (json['id'] as num).toInt(),
      targetType: json['targetType'] as String,
      targetDiscordId: json['targetDiscordId'] as String?,
      category: json['category'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      link: json['link'] as String?,
      source: json['source'] as String,
      sourceRef: json['sourceRef'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String).toUtc(),
    );
  }
}
