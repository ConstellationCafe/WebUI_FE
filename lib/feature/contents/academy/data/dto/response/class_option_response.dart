class ClassOptionResponse {
  final int id;
  final String classNumber;
  final String state;

  const ClassOptionResponse({
    required this.id,
    required this.classNumber,
    required this.state,
  });

  factory ClassOptionResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return ClassOptionResponse(
      id: json['id'],
      classNumber: json['classNumber'] as String,
      state: json['state'] as String,
    );
  }
}