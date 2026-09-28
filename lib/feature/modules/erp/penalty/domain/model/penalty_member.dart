class PenaltyMember {
  final String discordId;
  final String username;
  final int cumulativeScore30d;
  final int penaltyCount30d;
  final DateTime lastOccurredAt;

  const PenaltyMember({
    required this.discordId,
    required this.username,
    required this.cumulativeScore30d,
    required this.penaltyCount30d,
    required this.lastOccurredAt,
  });
}
