class PenaltyMember {
  final String discordId;
  final String displayName;
  final int cumulativeScore30d;
  final int penaltyCount30d;
  final DateTime lastOccurredAt;

  const PenaltyMember({
    required this.discordId,
    required this.displayName,
    required this.cumulativeScore30d,
    required this.penaltyCount30d,
    required this.lastOccurredAt,
  });
}
