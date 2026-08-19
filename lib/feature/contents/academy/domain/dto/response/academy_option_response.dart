class AcademyOptionResponse {
  final String id;
  final String name;

  const AcademyOptionResponse({
    required this.id,
    required this.name,
  });

  factory AcademyOptionResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return AcademyOptionResponse(
      id: json['id'].toString(),
      name: json['name'] as String,
    );
  }
}