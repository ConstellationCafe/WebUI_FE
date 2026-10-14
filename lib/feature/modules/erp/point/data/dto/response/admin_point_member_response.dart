class AdminPointMemberResponse {
  final String discordId;
  final String? displayName;
  final String state;
  final int coin;

  const AdminPointMemberResponse({
    required this.discordId,
    required this.displayName,
    required this.state,
    required this.coin,
  });

  factory AdminPointMemberResponse.fromJson(Map<String, dynamic> json) {
    return AdminPointMemberResponse(
      discordId: json['discordId'] as String,
      displayName: json['displayName'] as String?,
      state: json['state'] as String,
      coin: (json['coin'] as num).toInt(),
    );
  }
}
