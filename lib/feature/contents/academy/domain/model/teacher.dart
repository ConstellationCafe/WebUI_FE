import 'academy_member.dart';

class Teacher extends AcademyMember {
  const Teacher({
    required super.sk,
    required super.discordID,
    required super.name,
    super.profileImageUrl,
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