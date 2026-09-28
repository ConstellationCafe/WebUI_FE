class PenaltyHistoryResponse {
  final int penaltyId;
  final String channelId;
  final String? channelName;
  final String targetDiscordId;
  final String targetUsername;
  final String reason;
  final int score;
  final String issuerDiscordId;
  final DateTime occurredAt;
  final DateTime createdAt;
  final String status;
  final int targetCumulativeScore30d;
  final String? canceledByDiscordId;
  final DateTime? canceledAt;
  final String? cancellationReason;

  const PenaltyHistoryResponse({
    required this.penaltyId,
    required this.channelId,
    required this.channelName,
    required this.targetDiscordId,
    required this.targetUsername,
    required this.reason,
    required this.score,
    required this.issuerDiscordId,
    required this.occurredAt,
    required this.createdAt,
    required this.status,
    required this.targetCumulativeScore30d,
    required this.canceledByDiscordId,
    required this.canceledAt,
    required this.cancellationReason,
  });

  factory PenaltyHistoryResponse.fromJson(Map<String, dynamic> json) =>
      PenaltyHistoryResponse(
        penaltyId: (json['penaltyId'] as num).toInt(),
        channelId: json['channelId'] as String,
        channelName: json['channelName'] as String?,
        targetDiscordId: json['targetDiscordId'] as String,
        targetUsername: json['targetUsername'] as String,
        reason: json['reason'] as String,
        score: (json['score'] as num).toInt(),
        issuerDiscordId: json['issuerDiscordId'] as String,
        occurredAt: DateTime.parse(json['occurredAt'] as String).toUtc(),
        createdAt: DateTime.parse(json['createdAt'] as String).toUtc(),
        status: json['status'] as String,
        targetCumulativeScore30d: (json['targetCumulativeScore30d'] as num)
            .toInt(),
        canceledByDiscordId: json['canceledByDiscordId'] as String?,
        canceledAt: json['canceledAt'] == null
            ? null
            : DateTime.parse(json['canceledAt'] as String).toUtc(),
        cancellationReason: json['cancellationReason'] as String?,
      );
}
