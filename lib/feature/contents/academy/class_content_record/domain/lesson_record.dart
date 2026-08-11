class LessonRecord {
  final String academyId;
  final String className;
  final String subject;

  final DateTime educationDate;
  final Duration educationDuration;

  final String mainTeacherId;
  final List<String> coTeacherIds;

  final List<String> memberIds;

  final String description;

  const LessonRecord({
    required this.academyId,
    required this.className,
    required this.subject,
    required this.educationDate,
    required this.educationDuration,
    required this.mainTeacherId,
    required this.coTeacherIds,
    required this.memberIds,
    required this.description,
  });
}