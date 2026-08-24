class StudentOptionResponse {
  final String sk;
  final String discordID;
  final String name;

  const StudentOptionResponse({
    required this.sk,
    required this.discordID,
    required this.name,
  });

  factory StudentOptionResponse.fromJson(Map<String, dynamic> json) {
    return StudentOptionResponse(
      sk: json['sk'].toString(),
      discordID: json['discordID'].toString(),
      name: json['name'] as String,
    );
  }
}