class PenaltyMembersRequest {
  final String? discordId;
  final int page;
  final int size;

  const PenaltyMembersRequest({this.discordId, this.page = 1, this.size = 20});

  Map<String, dynamic> toJson() => {
    if (discordId != null && discordId!.isNotEmpty) 'discordId': discordId,
    'page': page,
    'size': size,
  };
}
