import 'academy_member.dart';

class Student extends AcademyMember {
  const Student({
    required super.sk,
    required super.discordID,
    required super.name,
    super.profileImageUrl,
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