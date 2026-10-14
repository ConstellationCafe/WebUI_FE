import 'academy_member.dart';

class Teacher extends AcademyMember {
  const Teacher({
    required super.sk,
    required super.discordId,
    required super.displayName,
    required super.state,
    super.profileImageUrl,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      sk: json['sk'].toString(),
      discordId: json['discordId'].toString(),
      displayName: json['displayName'].toString(),
      state: json['state'].toString(),
      profileImageUrl: json['profileImageUrl'].toString(),
    );
  }
}
