class Student {
  final String sk;
  final String discordID;
  final String name;
  final String? profileImageUrl;

  const Student({
    required this.sk,
    required this.discordID,
    required this.name,
    this.profileImageUrl,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      sk: json['sk'].toString(),
      discordID: json['discordID'].toString(),
      name: json['name'].toString(),
      profileImageUrl: json['profileImageUrl'].toString(),
    );
  }
}