class AcademyStudent {
  final String id;
  final String name;
  final String? profileImageUrl;

  const AcademyStudent({
    required this.id,
    required this.name,
    this.profileImageUrl,
  });

  factory AcademyStudent.fromJson(Map<String, dynamic> json) {
    return AcademyStudent(
      id: json['id'].toString(),
      name: json['name'].toString(),
      profileImageUrl: json['profileImageUrl'].toString(),
    );
  }
}