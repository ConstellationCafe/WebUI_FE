class AcademyTeacher {
  final String id;
  final String name;
  final String? profileImageUrl;

  const AcademyTeacher({
    required this.id,
    required this.name,
    this.profileImageUrl,
  });

  factory AcademyTeacher.fromJson(Map<String, dynamic> json) {
    return AcademyTeacher(
      id: json['id'].toString(),
      name: json['name'].toString(),
      profileImageUrl: json['profileImageUrl'].toString(),
    );
  }
}