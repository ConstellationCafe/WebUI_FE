class PenaltyMemberResponse {
  final String discordId;
  final String username;
  final int cumulativeScore30d;
  final int penaltyCount30d;
  final DateTime lastOccurredAt;

  const PenaltyMemberResponse({
    required this.discordId,
    required this.username,
    required this.cumulativeScore30d,
    required this.penaltyCount30d,
    required this.lastOccurredAt,
  });

  factory PenaltyMemberResponse.fromJson(Map<String, dynamic> json) =>
      PenaltyMemberResponse(
        discordId: json['discordId'] as String,
        username: json['username'] as String,
        cumulativeScore30d: (json['cumulativeScore30d'] as num).toInt(),
        penaltyCount30d: (json['penaltyCount30d'] as num).toInt(),
        lastOccurredAt: DateTime.parse(
          json['lastOccurredAt'] as String,
        ).toUtc(),
      );
}
