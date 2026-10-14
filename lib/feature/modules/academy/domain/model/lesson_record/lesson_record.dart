class LessonRecord {
  final int academyId;
  final String className;
  final String subjectName;

  final DateTime educationDate;
  final DateTime startTime;
  final DateTime endTime;
  final Duration educationDuration;

  final String mainTeacherSk;
  final List<String> coTeacherSks;

  final List<String> memberSks;

  final String description;

  const LessonRecord({
    required this.academyId,
    required this.className,
    required this.subjectName,
    required this.educationDate,
    required this.startTime,
    required this.endTime,
    required this.educationDuration,
    required this.mainTeacherSk,
    required this.coTeacherSks,
    required this.memberSks,
    required this.description,
  });

  String _formatTime(DateTime time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';

  Map<String, dynamic> toJson() {
    return {
      'academyId': academyId,
      'className': className,
      'subject': subjectName,
      'educationDate': educationDate.toIso8601String(),
      'startTime': _formatTime(startTime),
      'endTime': _formatTime(endTime),
      'educationDuration': educationDuration.inMinutes,
      'mainTeacherSk': mainTeacherSk,
      'coTeacherSks': coTeacherSks,
      'memberSks': memberSks,
      'description': description,
    };
  }
}
