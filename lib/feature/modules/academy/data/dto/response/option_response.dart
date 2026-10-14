class OptionResponse {
  final String sk;
  final String discordId;
  final String displayName;
  final String state;

  const OptionResponse({
    required this.sk,
    required this.discordId,
    required this.displayName,
    this.state = '',
  });

  factory OptionResponse.fromJson(Map<String, dynamic> json) {
    return OptionResponse(
      sk: json['sk']?.toString() ?? '',
      discordId: json['discordId']?.toString() ?? '',
      displayName: json['displayName']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
    );
  }
}
