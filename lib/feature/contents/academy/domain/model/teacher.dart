class Teacher {
  final String id;
  final String name;
  final String? profileImageUrl;

  const Teacher({
    required this.id,
    required this.name,
    this.profileImageUrl,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'].toString(),
      name: json['name'].toString(),
      profileImageUrl: json['profileImageUrl'].toString(),
    );
  }
}