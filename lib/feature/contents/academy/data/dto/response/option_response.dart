class OptionResponse {
  final String sk;
  final String discordID;
  final String name;

  const OptionResponse({
    required this.sk,
    required this.discordID,
    required this.name,
  });

  factory OptionResponse.fromJson(Map<String, dynamic> json) {
    return OptionResponse(
      sk: json['sk'].toString(),
      discordID: json['discordID'].toString(),
      name: json['name'] as String,
    );
  }
}