/// `GET /api/admin/competitions/boards` 응답 항목.
class CompetitionBoardResponse {
  final String key;
  final String channelId;
  final String name;
  final bool joinable;

  const CompetitionBoardResponse({
    required this.key,
    required this.channelId,
    required this.name,
    required this.joinable,
  });

  factory CompetitionBoardResponse.fromJson(Map<String, dynamic> json) {
    return CompetitionBoardResponse(
      key: json['key'] as String,
      channelId: json['channelId'] as String,
      name: json['name'] as String,
      joinable: json['joinable'] as bool,
    );
  }
}
