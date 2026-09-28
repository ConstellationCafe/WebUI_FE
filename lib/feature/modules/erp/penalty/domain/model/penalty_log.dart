class PenaltyLog {
  final int id;
  final String channelId;
  final String? channelName;
  final String targetDiscordId;
  final String targetUsername;
  final String reason;
  final int score;
  final String issuerDiscordId;
  final DateTime occurredAt;
  final DateTime createdAt;
  final bool isCanceled;
  final int targetCumulativeScore30d;
  final String? canceledByDiscordId;
  final DateTime? canceledAt;
  final String? cancellationReason;

  const PenaltyLog({
    required this.id,
    required this.channelId,
    required this.channelName,
    required this.targetDiscordId,
    required this.targetUsername,
    required this.reason,
    required this.score,
    required this.issuerDiscordId,
    required this.occurredAt,
    required this.createdAt,
    required this.isCanceled,
    required this.targetCumulativeScore30d,
    required this.canceledByDiscordId,
    required this.canceledAt,
    required this.cancellationReason,
  });
}
