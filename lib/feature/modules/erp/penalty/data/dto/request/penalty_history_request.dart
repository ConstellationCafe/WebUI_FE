class PenaltyHistoryRequest {
  final String? channelId;
  final String? discordId;
  final String sort;
  final int page;
  final int size;

  const PenaltyHistoryRequest({
    this.channelId,
    this.discordId,
    this.sort = 'OCCURRED_AT_DESC',
    this.page = 1,
    this.size = 20,
  });

  Map<String, dynamic> toJson() => {
    if (channelId != null && channelId!.isNotEmpty) 'channelId': channelId,
    if (discordId != null && discordId!.isNotEmpty) 'discordId': discordId,
    'sort': sort,
    'page': page,
    'size': size,
  };
}
