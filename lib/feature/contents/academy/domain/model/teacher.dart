class Teacher {
  final String sk;
  final String discordID;
  final String name;
  final String? profileImageUrl;

  const Teacher({
    required this.sk,
    required this.discordID,
    required this.name,
    this.profileImageUrl,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      sk: json['sk'].toString(),
      discordID: json['discordID'].toString(),
      name: json['name'].toString(),
      profileImageUrl: json['profileImageUrl'].toString(),
    );
  }
}