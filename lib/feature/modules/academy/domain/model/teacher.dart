import 'academy_member.dart';

class Teacher extends AcademyMember {
  const Teacher({
    required super.sk,
    required super.discordID,
    required super.name,
    required super.state,
    super.profileImageUrl,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      sk: json['sk'].toString(),
      discordID: json['discordID'].toString(),
      name: json['name'].toString(),
      state: json['state'].toString(),
      profileImageUrl: json['profileImageUrl'].toString(),
    );
  }
}
