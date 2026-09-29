class AcademyClass {
  /// Backend가 운영 중인 분반에 내려주는 state 값.
  static const operatingState = '운영';

  final int id;
  final String classNumber;
  final String state;

  const AcademyClass({
    required this.id,
    required this.classNumber,
    required this.state,
  });

  bool get isOperating => state == operatingState;

  factory AcademyClass.fromJson(Map<String, dynamic> json) {
    return AcademyClass(
      id: json['id'],
      classNumber: json['classNumber'],
      state: json['state'],
    );
  }
}
