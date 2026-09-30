/// `POST /api/admin/competitions` 응답.
class CompetitionPostResponse {
  final String boardKey;
  final String channelId;
  final String messageId;
  final String? messageUrl;
  final String content;

  const CompetitionPostResponse({
    required this.boardKey,
    required this.channelId,
    required this.messageId,
    required this.messageUrl,
    required this.content,
  });

  factory CompetitionPostResponse.fromJson(Map<String, dynamic> json) {
    return CompetitionPostResponse(
      boardKey: json['boardKey'] as String,
      channelId: json['channelId'] as String,
      messageId: json['messageId'] as String,
      messageUrl: json['messageUrl'] as String?,
      content: json['content'] as String,
    );
  }
}
