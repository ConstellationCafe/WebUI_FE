class AcademyClass {
  final int id;
  final int classNumber;
  final String state;

  const AcademyClass({
    required this.id,
    required this.classNumber,
    required this.state
  });

  factory AcademyClass.fromJson(Map<String, dynamic> json) {
    return AcademyClass(
      id: json['id'],
      classNumber: json['classNumber'],
      state: json['state']
    );
  }
}