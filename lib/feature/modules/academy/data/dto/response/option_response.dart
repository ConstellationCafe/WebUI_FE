class OptionResponse {
  final String sk;
  final String discordID;
  final String name;
  final String state;

  const OptionResponse({
    required this.sk,
    required this.discordID,
    required this.name,
    this.state = '',
  });

  factory OptionResponse.fromJson(Map<String, dynamic> json) {
    return OptionResponse(
      sk: json['sk']?.toString() ?? '',
      discordID: json['discordID']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
    );
  }
}
