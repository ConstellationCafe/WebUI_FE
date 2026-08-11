class AcademyTeacher {
  final String id;
  final String name;
  final String? profileImageUrl;

  const AcademyTeacher({
    required this.id,
    required this.name,
    this.profileImageUrl,
  });
}