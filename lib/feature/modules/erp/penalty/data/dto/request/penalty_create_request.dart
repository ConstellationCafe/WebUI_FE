class PenaltyCreateRequest {
  final String requestId;
  final String targetDiscordId;
  final String channelId;
  final String? channelName;
  final String reason;
  final int score;
  final DateTime? occurredAt;

  const PenaltyCreateRequest({
    required this.requestId,
    required this.targetDiscordId,
    required this.channelId,
    this.channelName,
    required this.reason,
    this.score = 1,
    this.occurredAt,
  });

  Map<String, dynamic> toJson() => {
    'requestId': requestId,
    'targetDiscordId': targetDiscordId,
    'channelId': channelId,
    if (channelName != null && channelName!.trim().isNotEmpty)
      'channelName': channelName!.trim(),
    'reason': reason.trim(),
    'score': score,
    if (occurredAt != null) 'occurredAt': occurredAt!.toUtc().toIso8601String(),
  };
}
