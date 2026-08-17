class Subject {
  final int id;
  final String name;

  const Subject({
    required this.id,
    required this.name,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
        id: json['id'],
        name: json['name'],
    );
  }
}