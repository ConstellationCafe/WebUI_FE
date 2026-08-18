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

  Map<String, dynamic> toJson() {
    return {
      'academyId': academyId,
      'className': className,
      'subject': subject,
      'educationDate': educationDate.toIso8601String(),
      'educationDuration': educationDuration.inMinutes,
      'mainTeacherId': mainTeacherId,
      'coTeacherIds': coTeacherIds,
      'memberIds': memberIds,
      'description': description,
    };
  }
}