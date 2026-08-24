class AcademyOptionResponse {
  final int id;
  final String name;

  const AcademyOptionResponse({
    required this.id,
    required this.name,
  });

  factory AcademyOptionResponse.fromJson(Map<String, dynamic> json) {
    return AcademyOptionResponse(
      id: json['id'].toInt(),
      name: json['name'] as String,
    );
  }
}