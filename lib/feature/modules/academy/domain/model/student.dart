import 'academy_member.dart';

class Student extends AcademyMember {
  const Student({
    required super.sk,
    required super.discordId,
    required super.displayName,
    required super.state,
    super.profileImageUrl,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      sk: json['sk'].toString(),
      discordId: json['discordId'].toString(),
      displayName: json['displayName'].toString(),
      state: json['state'].toString(),
      profileImageUrl: json['profileImageUrl'].toString(),
    );
  }
}
