class StudentOptionResponse {
  final String id;
  final String name;

  const StudentOptionResponse({
    required this.id,
    required this.name,
  });

  factory StudentOptionResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return StudentOptionResponse(
      id: json['id'].toString(),
      name: json['name'] as String,
    );
  }
}