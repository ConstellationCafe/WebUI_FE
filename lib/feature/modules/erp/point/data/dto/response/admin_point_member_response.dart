class AdminPointMemberResponse {
  final String discordId;
  final String? username;
  final String state;
  final int coin;

  const AdminPointMemberResponse({
    required this.discordId,
    required this.username,
    required this.state,
    required this.coin,
  });

  factory AdminPointMemberResponse.fromJson(Map<String, dynamic> json) {
    return AdminPointMemberResponse(
      discordId: json['discordId'] as String,
      username: json['username'] as String?,
      state: json['state'] as String,
      coin: (json['coin'] as num).toInt(),
    );
  }
}
