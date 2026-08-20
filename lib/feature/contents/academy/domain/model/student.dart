class Student {
  final String id;
  final String name;
  final String? profileImageUrl;

  const Student({
    required this.id,
    required this.name,
    this.profileImageUrl,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'].toString(),
      name: json['name'].toString(),
      profileImageUrl: json['profileImageUrl'].toString(),
    );
  }
}