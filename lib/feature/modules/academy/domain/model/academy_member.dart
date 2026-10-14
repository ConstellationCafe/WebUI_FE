abstract class AcademyMember {
  final String sk;
  final String discordId;
  final String displayName;
  final String state;
  final String? profileImageUrl;

  const AcademyMember({
    required this.sk,
    required this.discordId,
    required this.displayName,
    required this.state,
    this.profileImageUrl,
  });
}
