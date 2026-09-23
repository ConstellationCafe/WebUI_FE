class LessonRecordView {
  final String id;
  final String academyName;
  final String className;
  final String subjectName;
  final DateTime educationDate;
  final DateTime? startTime;
  final DateTime? endTime;
  final Duration educationDuration;
  final String mainTeacherName;
  final String description;
  final int memberCount;

  const LessonRecordView({
    required this.id,
    required this.academyName,
    required this.className,
    required this.subjectName,
    required this.educationDate,
    required this.startTime,
    required this.endTime,
    required this.educationDuration,
    required this.mainTeacherName,
    required this.description,
    required this.memberCount,
  });
}
