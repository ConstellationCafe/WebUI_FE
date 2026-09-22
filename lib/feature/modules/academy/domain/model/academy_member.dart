abstract class AcademyMember {
  final String sk;
  final String discordID;
  final String name;
  final String state;
  final String? profileImageUrl;

  const AcademyMember({
    required this.sk,
    required this.discordID,
    required this.name,
    required this.state,
    this.profileImageUrl,
  });
}
