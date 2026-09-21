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
      id: int.parse(json['id'].toString()),
      classNumber: json['classNumber']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
    );
  }
}
