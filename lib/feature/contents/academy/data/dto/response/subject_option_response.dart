class SubjectOptionResponse {
  final int id;
  final String name;

  const SubjectOptionResponse({
    required this.id,
    required this.name,
  });

  factory SubjectOptionResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return SubjectOptionResponse(
      id: json['id'],
      name: json['name'] as String,
    );
  }
}