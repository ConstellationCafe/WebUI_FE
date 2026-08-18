class LessonRecordSummary {
  final String id;
  final String academyName;
  final String className;
  final String subject;
  final DateTime educationDate;
  final Duration educationDuration;
  final String mainTeacherName;
  final String description;
  final int memberCount;

  const LessonRecordSummary({
    required this.id,
    required this.academyName,
    required this.className,
    required this.subject,
    required this.educationDate,
    required this.educationDuration,
    required this.mainTeacherName,
    required this.description,
    required this.memberCount,
  });

  factory LessonRecordSummary.fromJson(
      Map<String, dynamic> json,
      ) {
    return LessonRecordSummary(
      id: json['id'].toString(),
      academyName: json['academyName'] ?? '',
      className: json['className'] ?? '',
      subject: json['subject'] ?? '',
      educationDate: DateTime.parse(
        json['educationDate'],
      ),
      educationDuration: Duration(
        minutes: json['educationDuration'] ?? 0,
      ),
      mainTeacherName: json['mainTeacherName'] ?? '',
      description: json['description'] ?? '',
      memberCount: json['memberCount'] ?? 0,
    );
  }
}